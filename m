Date: Mon, 17 Jun 2002 10:58:27 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440 PCI adapter card interupt handling question
Message-ID: <20020617105827.A1397@home.com>
References: <20020615082112.B737@home.com> <20020617173211.14748.qmail@web11505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020617173211.14748.qmail@web11505.mail.yahoo.com>; from kqtrinh@yahoo.com on Mon, Jun 17, 2002 at 10:32:11AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 17, 2002 at 10:32:11AM -0700, Khai Trinh wrote:
> But Matt,
>
> request_irq() is used to register the ISR with an irq#
> between 0-12 (for the 440). However, the inbound
> message interrupt is hardwire as you stated. How can I
> use request_irq() to register hardwire interrupt
> signal to the UIC? Or is there another kernel call to
> handle such services?

You've lost me, request_irq() isn't limited to Linux interrupt
numbers 0-12 on 440.  Everything on the cascaded UICs has been
populated in the irq_desc and is therefore available.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
