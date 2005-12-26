Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0889768932
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Dec 2005 08:19:12 +1100 (EST)
To: "Zhang Xin-W22390" <W22390@motorola.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Dec 2005 20:43:49 +0800."
	<917BB953409D9D4E86FDD8AE553CA873214B24@zmy16exm62.ds.mot.com>
Date: Mon, 26 Dec 2005 22:19:10 +0100
Sender: wd@denx.de
Message-Id: <20051226211910.2CC0A353AED@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Can I use the system call provided by uboot in an assembly
	language program as in ppcbug?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <917BB953409D9D4E86FDD8AE553CA873214B24@zmy16exm62.ds.mot.com> you wrote:
> 
> I want to call some system calls to do input/ouput in assembly language
> program, and does uboot provide such syscall? As in PPCBUG, I can

If you are running in  the  U-Boot  environment,  then  you  can  use
standard  C programs; read about "standalone applications" - but this
is off topic here; please  read  the  docs  and  post  any  remaining
questions on the u-boot-users mailing list.

Once you started the Linux kernel, then all of  U-Boot  is  gone  and
dead and there is no way to call any U-Boot code any more - except by
resetting the board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Of course there's no reason for it, it's just our policy.
