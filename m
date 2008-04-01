Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with ESMTP id 74467DDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 17:07:34 +1100 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	AEC421000AA8for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 08:07:31 +0200 (CEST)
Message-ID: <47F1D121.2020500@fz-juelich.de>
Date: Tue, 01 Apr 2008 08:07:29 +0200
From: Georg Schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: JFFS2 root-fs
References: <EE63F03D9E04774997AEBCD21FC77F251E9878@ccomm-ex1.ccomm.com>
In-Reply-To: <EE63F03D9E04774997AEBCD21FC77F251E9878@ccomm-ex1.ccomm.com>
Content-Type: text/plain;
	charset=ISO-8859-1;
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



Sugathan, Rupesh schrieb:
>  
> It seems to me, that the kernel does not find ANY file. because the
> /dev/console file is in the image, but the initial console is not found
> too
>
> 1) You should probably unpack and mount the jffs2 image on your host
> directory to ensure that you see all files in place. 
>   
i see all the files with the u-boot jffs2 commands, but will try to 
mount the jffs image on the host
> 2) Check to see if your designated flash partition can hold all of your
> jffs2 image.
>   
yes, its big enough
> Were you able to use the 'same' rootfs in any other way (nfs mount or
> ramdisk) on the target?
>   

i will try this

Thanks
Georg
> Thanks
> --
> Rupesh Sugathan
>
>   



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
