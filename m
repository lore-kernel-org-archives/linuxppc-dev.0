Return-Path: <ut@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED65318.versanet.de
	[62.214.83.24]) by ozlabs.org (Postfix) with ESMTP id 385666876A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 11:00:08 +1100 (EST)
Message-Id: <200511122351.jACNpiG5016918@arbas.nms.ulrich-teichert.org>
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 13 Nov 2005 00:51:43 +0100 (MET)
In-Reply-To: <1131834667.7406.49.camel@gaston>
From: Ulrich Teichert <ulrich.teichert@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

[trimmed the cc list a bit]
>Yes, PREP need to be migrated, but that includes adding some minimum
>device-tree support for it among others. And few people still have PREP
>machines, I'm not even sure we have access to one here in ozlabs... I
>think for 2.6.15, we'd better just disable it in .config for
>ARCH=powerpc.

for what's it worth, I'm still owning:

wehrle:~> uname -a
Linux wehrle 2.4.19 #3 Sun Aug 4 08:28:30 BST 2002 ppc unknown
wehrle:~> cat /proc/cpuinfo 
cpu             : 604r
clock           : 199MHz
revision        : 18.3 (pvr 0009 1203)
bogomips        : 397.31
machine         : PReP IBM 43P-140 (Tiger1)
upgrade cpu     : not present
scsi fuse       : ok
simms           : 1:128MiB 2:128MiB 3:128MiB 4:128MiB 5:128MiB 
l2 cache        : sync burst, parity, 1MiB

and

sed:~> uname -a
Linux sed 2.4.28 #8 Mon Dec 13 22:16:08 CET 2004 ppc unknown
sed:~> cat /proc/cpuinfo 
processor       : 0
cpu             : 604r
clock           : ???
revision        : 49.2 (pvr 0009 3102)
bogomips        : 299.00
machine         : PReP Utah (Powerstack II Pro4000)
l2 cache        : 512KiB, parity disabled SRAM:synchronous, pipelined, no parity

Especially the 43p-140 is quite easy to get via ebay, the Powerstack II
is a more rare machine nowadays, I think.

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Opération S)
