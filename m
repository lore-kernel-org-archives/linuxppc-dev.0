Subject: Re: EP405 GPIO signal problem
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: t.vanremortel@ha.be
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Embedded PPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20031120181921.GA3365@gate.ebshome.net>
References: <1069336934.1290.6.camel@toni>
	 <20031120181921.GA3365@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1069402906.4172.6.camel@toni>
Mime-Version: 1.0
Date: Fri, 21 Nov 2003 09:21:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op do 20-11-2003, om 19:19 schreef Eugene Surovegin:
> On Thu, Nov 20, 2003 at 03:02:15PM +0100, Toni Van Remortel wrote:
> > I have an RTAI powered kernel module which outputs 32 bits data via the
> > EP405 GPIO ports from the IBM 405GP CPU. These outputs are multiplexed
> > with other signals.
> > Problem: when I output the 32 bits as one like this:
> > writel( buffer, (u32)gpio_base_addr+GPIO0_OR );
> > (where buffer is of u32 type)
>
> One thing which looks strange to me. Are you sure you can use 32 GPIO
> pins?

Ain't possible, I know.

> This is impossible because 405GP has only 23, and I doubt you can use
> even this number, because some of the pins are shared with IRQ and
> PerCSx lines.

You can set all 23 GPIO's as output. I actually only use 17 of them (2 x
8bit position and 1 on/off).
Now I've taken a deeper look at the problem, it might be caused by the
EP405 itself. My DAC settles at 70ns.
I still have to check if the signals are outputted all at the same time.
Should go and fetch a logic analyzer somewhere ;)

--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
