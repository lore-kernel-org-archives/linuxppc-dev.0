To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LXT972 FEC problem on MPC855 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Aug 2002 11:04:13 PDT."
             <3D6A6D9D.20404@redswitch.com>
Date: Mon, 26 Aug 2002 20:27:02 +0200
Message-Id: <20020826182707.BA14B11829@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D6A6D9D.20404@redswitch.com> you wrote:
>
> > After running ppcboot on our board successfully (including the fast
> > ethernet LXT972), we have trouble on enabling FEC on linux kernel. The
> > problem is that we cannot send any packets through the network after the
> > kernel is booted. The ethernet looks OK during initialization according
> > to the printed messages. We are trying to locate the problem but haven't
> > found yet so far. Any hints on what caused such problem?
...
> eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
> IP-Config: Incomplete network configuration information.

You are passing bad/insufficient boot arguments to the Linux  kernel;
unfortunaltely you don;t show us this part of the boot messages, so I
cannot even guess what you're doing wrong.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not underestimate the value of print statements for debugging.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
