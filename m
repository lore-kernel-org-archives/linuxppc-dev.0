To: "Jacky Lam" <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut boot problem solved 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Oct 2003 11:06:14 +0800."
             <009a01c38bb6$ceb84f40$2803050a@JackyLam>
Date: Tue, 07 Oct 2003 00:40:17 +0200
Message-Id: <20031006224023.069E7C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Jacky,

in message <009a01c38bb6$ceb84f40$2803050a@JackyLam> you wrote:
>
>     I have figured out why my kernel hanged while booting on Walnut
> platform. It is because the structure of board_info is different between
> u-boot-0.4.8 and linuxppc-2.4-devel. After syncing the structure, I can boot

Does the fact that this is a FAQ tell you something?

> up to where the kernel tries to mount the filesystem. Attached is a patch
> for the fix.

This patch is not really useful. Instead of redefining the  structure
yourself you should simply #include <asm/ppcboot.h>.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
By the way, ALL software projects are done by iterative  prototyping.
Some companies call their prototypes "releases", that's all.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
