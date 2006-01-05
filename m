Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E822A689AF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 18:35:51 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 5 Jan 2006 08:35:41 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNKEKACEAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Porting of Linux on MPC8260 custom build board
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Batsayan Das,

[...]
> zone(2): 0 pages.
> Kernel command line: root=/dev/mtdblock2

I think you do not use NFS as root fs.
Try something like root=/dev/nfs in the Kernel
command line, or read

http://www.denx.de/wiki/view/DULG/LinuxNfsRoot

Best regards
Heiko
