Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:07:03 -0500 (CDT)
Subject: [PATCH 0/15] bootwrapper: support for kexec to zImage
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series creates a 32 bit zImage wrapper for a 32 or 64 bit PowerPC
Linux kernel.   This allows you to kexec a zImage with its compressed
vmlinux instead of the uncompressed vmlinux elf.  The elf is also
packaged as a 64 bit elf for use by kexec-tools for 64 bit kernels.

This series also adds code to extract the vmlinux elf file from an
initramfs (or other platform supplied location).  This allows one
to load the elf once (compressed) and use it both for userspace and
for the actual boot.

milton
