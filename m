Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7EB8FDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 12:59:11 +1000 (EST)
Message-ID: <466622FA.7030200@am.sony.com>
Date: Tue, 05 Jun 2007 19:59:06 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/18] PS3 patches for 2.6.23
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Here is a series I have for 2.6.23.

Patches 1-8 are more or less independent of each other.
Patches 9-18 are a dependent series of my system bus
rework patches. 

[01/18] Cell: Add spu shutdown method
[02/18] PS3: Rename IPI symbols
[03/18] PS3: Use __maybe_unused
[04/18] PS3: Compare firmware version
[05/18] PS3: Fix sparse warnings
[06/18] PS3: Add support for HDMI RGB Full Range mode
[07/18] PS3: Make ps3av.h usable from user space
[08/18] PS3: Kexec support
[09/18] PS3: System-bus rework
[10/18] PS3: System-bus uevent
[11/18] PS3: System-bus modinfo attribute
[12/18] PS3: Repository probe cleanups
[13/18] PS3: USB system-bus rework
[14/18] PS3: vuart rework
[15/18] PS3: sys-manager re-work
[16/18] PS3: Rework AV settings driver
[17/18] PS3: frame buffer system-bus rework
[18/18] PS3: Device registration routines.

-Geoff
 

-- 
