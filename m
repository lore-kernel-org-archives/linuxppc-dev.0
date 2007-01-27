Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 3E5EBDE1F3
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 22:30:16 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/16] ps3: get firmware version
Date: Sat, 27 Jan 2007 12:30:06 +0100
References: <45BAC225.7020209@am.sony.com>
In-Reply-To: <45BAC225.7020209@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701271230.06534.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 January 2007 04:08, Geoff Levand wrote:
> Add a new routine ps3_get_firmware_version() and use it to output the firmware
> version to dmesg.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

> Changed from a struct to a union and got rid of the output to /proc/cpuinfo.
> I'll look into arranging something in /proc/device-tree that userspace utils
> can query.

What's the current plan for the creating the device tree anyway? I think
this should be part of the boot wrapper for the kernel in the ps3 flash,
which can write the version into the flattened device tree. The second
kernel then gets a copy of that through kboot.

	Arnd <><
