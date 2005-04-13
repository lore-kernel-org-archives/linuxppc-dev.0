Return-Path: <torsten.demke@motorola.com>
Received: from motgate6.mot.com (motgate6.mot.com [144.189.100.106])
	by ozlabs.org (Postfix) with ESMTP id 980D167B59
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 19:17:08 +1000 (EST)
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate6.mot.com (Motorola/Motgate6) with ESMTP id j3D9H6B8019279
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 02:17:06 -0700 (MST)
Received: from zwg57exm01.ds.mot.com (zwg57exm01.ea.mot.com [10.170.189.6])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id j3D9I7HV016508
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2005 04:18:09 -0500 (CDT)
Message-ID: <43395BE65409D911B9FF00110A9BFFDC01955581@zwg57exm01.ea.mot.com>
From: Demke Torsten-atd012 <torsten.demke@motorola.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Wed, 13 Apr 2005 11:16:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

just another one:

echo `cat /proc/device-tree/model`
PowerBook5,5

for i in `find /proc/device-tree -name layout-id -print`; do echo $i && hexdump -n4 $i; done
Nothing

Regards,
Torsten


> -----Original Message-----
> From: linuxppc-dev-bounces@ozlabs.org
> [mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of Benjamin
> Herrenschmidt
> Sent: Samstag, 9. April 2005 02:31
> To: debian-powerpc@lists.debian.org; linuxppc-dev list
> Subject: Sound drivers for newer machines: need help
> 
> 
> Hi !
> 
> If you have a newer machine, that is a machine released on or after
> 2002, can you please send me the output of:
> 
> echo `cat /proc/device-tree/model`
> 
> and
> 
> for i in `find /proc/device-tree -name layout-id -print`; do 
> echo $i && hexdump -n4 $i; done
> 
> If the later returns nothing, it's fine, just tell me.
> 
> I'm especially interested in the various models of G5 based 
> machines. It
> seems apple is having all sorts of very different sound HW setups on
> those machines, and I'm trying to figure out exactly what is 
> where based
> on those infos and the darwin sources.
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
