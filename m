To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fast ethernet LXT972A support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Aug 2002 13:24:50 PDT."
             <3D654892.30500@redswitch.com>
Date: Fri, 23 Aug 2002 01:34:08 +0200
Message-Id: <20020822233413.E2CBD11822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D654892.30500@redswitch.com> you wrote:
>
> I noticed that only LXT970 and 971 are supported in the lastest kernel
> distribution from DENX. But the comments in fec.c say "includes support
> for following PHYs: QS6612, LXT970, LXT971/2". Does it mean that LXT972
> can use 971's driver? If not, basically what kind of modification is
> needed? Thanks.

Ummm.... you must be looking in the wrong place; our  kernel  version
supports  AMD79C874, LXT970, LXT971, QS6612, DP83843, and DP83846A on
MPC8xx processors, and AMD79C873, LXT970, LXT971, QS6612  on  MPC8260
processors.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
