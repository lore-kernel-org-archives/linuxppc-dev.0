Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with ESMTP id 2AF5ADDE03
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 21:02:57 +1100 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	5472410009AEfor <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 12:02:55 +0200 (CEST)
Message-ID: <47F4AB4B.1060504@fz-juelich.de>
Date: Thu, 03 Apr 2008 12:02:51 +0200
From: Georg Schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problems with busybox or filesystem ...
Content-Type: text/plain;
	charset=ISO-8859-15;
	format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,



its strange, now i have a filesystem with busybox 1.7.0 working if  i 
boot from systemace - module.
if i create a jffs2 image with the same filesystem, put it into flash 
and try to boot from flash busybox hangs after a few bytes of output. 
using kernel 2.6 from git.xilinx.com on a virtex4fx12 minimodul:

Output from kernel, and a few Bytes from busybox:

[    2.219956] VFS: Mounted root (jffs2 filesystem).
[    2.224084] Freeing unused kernel memory: 100k init
init
2.6. Lin

and then nothing :)

i tried a few other things:
- put the rootfs in a ramdisk -> same problem, but sometimes a few bytes 
more output :)
- change busybox version -> same problem
- change to secretlab kernel -> same problem
- use another gcc glibc version on crosscompiler -> same version


Whats wrong ? Its just a device missing ? Does the kernel unmounts the 
rootfs after starting init or something like this ? i this a problem 
with the console/serial device ?  i have no idea what i can try next.


its very frustrating  :)
thanks
georg


-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDir'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Prof. Dr. Harald Bolt,
Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
