Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 7EF45DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 10:22:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Cannot login via tinylogin on sequoia
Date: Fri, 30 Nov 2007 15:10:09 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C028D2294@ehost011-3.exch011.intermedia.net>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE48710BA65802@VCAEXCH01.hq.corp.viasat.com>
References: Your message of "Fri, 30 Nov 2007
	14:33:38+0100."<f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com><20071130221554.3AA0124075@gemini.denx.de>
	<821B2170E9E7F04FA38DF7EC21DE48710BA65802@VCAEXCH01.hq.corp.viasat.com>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I have built u-boot, kernel and filesystem using ELDK 4.1 for AMCC
PPC440EPx sequoia board. When I boot linux using NFS filesystem,
supplied with ELDK itself, I can login (usrr root, no password). However
I couldn't login while used ramdisk, built by myself or taken from AMCC
resource CD. Combinations root/root or root/nothing don't work.=20

Sequoia login: root
Password:
Login incorrect

Please press Enter to activate this console. Dec 31 18:00:26 Sequoia
auth.warn login[37]: invalid password for `UNKNOWN' on `ttyS0'
Dec 31 18:00:26 Sequoia daemon.info init: Process '/bin/tinylogin login
-f root' (pid 37) exited.  Scheduling it for restart.

How I can learn what user/password combination are configured and how do
I change them? This is static/etc/passwd from my SIMPLE filesystem:

root::0:0:root:/root:/bin/sh
bin:*:1:1:bin:/bin:
daemon:*:2:2:daemon:/sbin:
halt:*:7:0:halt:/sbin:/sbin/halt
ftp:*:14:50:FTP User:/
nobody:*:99:99:Nobody:/:
target:$1$x4Rc1j78$n5FVlLwarSyMYoZaMlijU1:200:100:Test
User:/home:/bin/sh

Thanks,

Leonid.
