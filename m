Message-ID: <20040310155641.48809.qmail@web15205.mail.bjs.yahoo.com>
Date: Wed, 10 Mar 2004 23:56:41 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: RE: RAM Disk problems
To: Wolfgang Denk <wd@denx.de>,
	Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	"'Jaap-Jan Boor'" <jjboor@aimsys.nl>,
	"Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F5BB0E4@ORION>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Kevin,

Yeah,first check your command setting as Jaap-Jan said
and make sure it has the right format and correct
content.If it couldn't work,pls try to rebuilding your
LINUX kernel as Wolfgang suggested and download the
workable ramdisk from ftp.denx.de like Steven told.

The setting of ramargs for your reference:

u-boot>setenv ramargs setenv bootargs root=/dev/ram rw

> Jaap-Jan wrote:
>
> > I think I once had the same problem and it was caused by having the
> > kernel cmd line overwritten. You might check that.

Wolfgang Denk wrote:
> This is an ext2 based ramdisk? Do you have ext2 support enabled in
> your kernel? If yes, try disabling devfs.

Steven Blakeslee wrote:
> Also you can try an already created ramdisk that is known to work. You
> can download one from Wolfgang's site. www.denx.de

Hope this would work.

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
