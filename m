Return-Path: <wd@denx.de>
To: "KylongMu" <mqy@263.net.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Nov 2005 10:04:14 +0800."
	<20051111020420.9644C1073@smtp.263.net>
Date: Fri, 11 Nov 2005 09:39:08 +0100
Sender: wd@denx.de
Message-Id: <20051111083908.42494353C42@atlas.denx.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: 11-11-05 2.6.14 on AMCC Yosemite board(boot error) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051111020420.9644C1073@smtp.263.net> you wrote:
> 
> 	With today's update, I can make the kernel by Yosemite_defconfig,
> but
> When boot my board with this new kernel, it halt at boot time, the
> attachment
> Is the boot message.

What you show is NOT the current code.

> U-Boot 1.1.3 (Sep  7 2005 - 09:03:02)

Please update U-Boot as well. You need this commit included:

commit f190c11b1f22ff766e046588e5a7bb55f28ae305
tree 1c41a7beffe8a293174dcb7c28b394349204a047
parent 4d03a21f2329bb13a9661a23742ac0b77a7a76d5
author Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100
committer Stefan Roese <sr@denx.de> Sat, 05 Nov 2005 15:50:16 +0100

    Adjust bd->bi_flashstart on Yellowstone & Yosemite to correct size
    Patch by Stefan Roese, 05 Nov 2005

I recommend to use the top-of-tree from the CVS or GIT repositories.

> Linux version 2.6.14 (root@dxp) (gcc version 4.0.0) #1 Fri Nov 11
> 09:51:04 CST 2005

This is not the current code base. You should  use  top-of-tree  from
GIT repository (commit ff1df84b3c3154ffdb646941e1c70d17554e3042); the
kernel will display something like this:

Linux version 2.6.14-gff1df84b ...



Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
                  Nail here --X-- for new monitor.
