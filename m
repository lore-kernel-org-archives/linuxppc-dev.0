Message-ID: <20040227080733.34958.qmail@web15203.mail.bjs.yahoo.com>
Date: Fri, 27 Feb 2004 16:07:33 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: Re: ADS860 - unable to load kernel- Bad magic number
To: m.venkatraj@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <301A812E6528D511A8F70008C71E578601FCF4F6@ap-bang-m02.india.tek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


m.venkatraj@exgate.tek.com wrote:
> The compilation goes through fine, I get "vmlinux" on the top-dir, and
> also a vmlinux.gz in the arch/ppc/boot/images if I do a "make zImage".
>
> When I configure bootp, and bootup the board, u-boot comes up fine,
> the tftp download of the kernel image goes through fine too. Then I
> am stuck with a "Bad Magic Number". Some initial digup led me to a
> mismatched image header magic number.

This is really a FAQ on U-BOOT.Note,U-BOOT can only
boot LINUX kernel and RAMDISK in its format-by mkimage
tools.You should convert vmlinux.gz as its required
format.Detailes pls see README in u-boot root
directory.Also,reading the following document
carefully is very helpful:
http://www.denx.de/twiki/bin/view/DULG/Manual

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
