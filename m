To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: "Dave Ellis" <DGE@sixnetio.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Why FEC and SCC1 can not work at the same time? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 18 Sep 2002 13:42:00 +0800."
             <001801c25ed6$1c389e00$7301a8c0@zhongqx>
Date: Wed, 18 Sep 2002 18:40:05 +0200
Message-Id: <20020918164010.D32BAFA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001801c25ed6$1c389e00$7301a8c0@zhongqx> you wrote:
>
>    thank you very much,
>    what you said is very right,fix ppcboot just like you said,and the proplem disappear!

Oops??? Dave did not mention any changes to PPCBoot, it seems.

PPCBoot is not to blame for your trouble.

> ----- Original Message -----
> From: "Dave Ellis" <DGE@sixnetio.com>
> To: "'zhongqx'" <zhongqx@guoguang.com.cn>
> Cc: <linuxppc-embedded@lists.linuxppc.org>
> Sent: Wednesday, September 18, 2002 4:20 AM
> Subject: RE: Why FEC and SCC1 can not work at the same time?
>
...
> > For FADS PPCBoot sets up both BCSR1 and BCSR4 in cpu/mpc8xx/scc.c.
> > In Linux 2.4.18 only BCSR1 is configured in arch/ppc/8xx_io/enet.c
> > Maybe configuring BCSR4 in enet.c would help.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
