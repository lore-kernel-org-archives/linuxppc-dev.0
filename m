Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <000d01c38c5b$99ebdcf0$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20031006224023.069E7C59E4@atlas.denx.de>
Subject: Re: Walnut boot problem solved 
Date: Tue, 7 Oct 2003 06:45:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, October 07, 2003 6:40 AM
Subject: Re: Walnut boot problem solved


> Hi Jacky,
>
> in message <009a01c38bb6$ceb84f40$2803050a@JackyLam> you wrote:
> >
> >     I have figured out why my kernel hanged while booting on Walnut
> > platform. It is because the structure of board_info is different between
> > u-boot-0.4.8 and linuxppc-2.4-devel. After syncing the structure, I can
boot
>
> Does the fact that this is a FAQ tell you something?

    No...just my blind guess while tracing the code.
>
> > up to where the kernel tries to mount the filesystem. Attached is a
patch
> > for the fix.
>
> This patch is not really useful. Instead of redefining the  structure
> yourself you should simply #include <asm/ppcboot.h>.

    Thanks. (Will you change it in next release?)

Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
