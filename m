To: "Michael Hao" <linux_powerpc@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to choose cpu with pci and fec function ?? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Aug 2004 10:14:21 +0800."
             <BAY22-F42IsiVjZXB2j00026a37@hotmail.com>
Date: Mon, 16 Aug 2004 09:35:29 +0200
Message-Id: <20040816073534.65B38C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY22-F42IsiVjZXB2j00026a37@hotmail.com> you wrote:
>
> Perhaps we will develop an embeded system with pci function and plan to use
> mpc,Can you give me some good suggestions?

Use "mpc"? Which sort of? MPC8xx  family?  MPC8240  family?  MPC8260?
MPC85xx? MPC52xx? Maybe MPC5xx?

Sorry, but you need to dig a bit deeper...

> how about mpc860?  during the transplanting bootloader ,which is the most

There is no PCI interface on MPC860 processors.

> refering board in Bootloader ,TQM860L?

THe TQM860 is definitely a bad choice if you're looking for PCI as  it has none.

> by the way ,how about mpc8250 and mpc8241??

Yeah, how about irt? An how about MPC5200 and all the other  zillions
of options you have?

We don't know your requirements.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Real programmers don't comment their code. It was hard to  write,  it
should be hard to understand.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
