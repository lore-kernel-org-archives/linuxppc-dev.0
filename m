Date: Thu, 20 Nov 2003 10:19:22 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Toni Van Remortel <t.vanremortel@ha.be>
Cc: Embedded PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EP405 GPIO signal problem
Message-ID: <20031120181921.GA3365@gate.ebshome.net>
References: <1069336934.1290.6.camel@toni>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1069336934.1290.6.camel@toni>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 20, 2003 at 03:02:15PM +0100, Toni Van Remortel wrote:
> I have an RTAI powered kernel module which outputs 32 bits data via the
> EP405 GPIO ports from the IBM 405GP CPU. These outputs are multiplexed
> with other signals.
> Problem: when I output the 32 bits as one like this:
> writel( buffer, (u32)gpio_base_addr+GPIO0_OR );
> (where buffer is of u32 type)

One thing which looks strange to me. Are you sure you can use 32 GPIO
pins?

This is impossible because 405GP has only 23, and I doubt you can use
even this number, because some of the pins are shared with IRQ and
PerCSx lines.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
