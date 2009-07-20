Return-Path: <DusharaJ@optiscan.com>
Received: from mailsvr.optiscan.com (mailsvr.optiscan.com [203.26.112.22])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 719C9B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 12:10:26 +1000 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 20 Jul 2009 12:04:53 +1000
Subject: Mounting a USB flash stick based root FS directly.
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C20DE6983@mailsvr>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm attempting to mount the root file system directly from a USB flash stic=
k (thus avoiding a ram-disk). The init thread is delayed until the USB devi=
ce is enumerated. However, I find the call to sys_mount() in line 218 @ htt=
p://git.denx.de/?p=3Dlinux-2.6-denx.git;a=3Dblob;f=3Dinit/do_mounts.c;h=3D8=
d4ff5afc1d80b56963cbf119b162a3ebce61124;hb=3Dad2a8c8d0593bf2d1ef163f1ca7574=
f02b2e770e fails. The problem is I can't work out where sys_mount() is impl=
emented.

I'm working off the 2.6.29-DENX kernel (commit id ad2a8c8d0593bf2d1ef163f1c=
a7574f02b2e770e). and My target CPU is an
mpc8349.


Thanks in advance.


Dushara Jayasinghe
