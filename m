Date: Thu, 18 Sep 2003 11:11:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx pcmcia cardmgr problem
Message-ID: <20030918181116.GD6692@ip68-0-152-218.tc.ph.cox.net>
References: <3439AB3A99ECD5409F3A52ACF814744D158D87@norcom2.norcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D87@norcom2.norcom.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 08:42:47AM -0400, Lokesh Kumar wrote:
> Thanks Tom,
>
> I did search on google but found no patch againt airo.c for 2.4.18. Anything
> you or anybody else aware of?

Now that I think of it, all you might have to do is to change the call
in airo.c from request_irq() to request_8xxirq().  But I haven't done
that myself.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
