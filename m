Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82B5768300
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 06:10:16 +1000 (EST)
Message-ID: <43330F99.3010906@orkun.us>
Date: Thu, 22 Sep 2005 15:10:01 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <432B3D99.5030209@orkun.us>
	<20050916224131.GA9941@gate.ebshome.net>
In-Reply-To: <20050916224131.GA9941@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: squashfs on ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the reply. I've built file system images based on ext2, 
cramfs and squashfs (2.1).

Uncompressed ext2 image is about 12MB consisting mostly of busybox, 
other executables and shared libraries etc. Everything is stripped.

cramfs based image took the least ram allocation but the most flash 
space (18% more than gzipped ext2 image).
squashfs was close to cramfs in ram usage but was about equal to gzipped 
ext2 image.

Thus, I have found squashfs based initrd to be good blance between ram 
and flash.


Eugene Surovegin wrote:

>On Fri, Sep 16, 2005 at 04:48:09PM -0500, Tolunay Orkun wrote:
>  
>
>>Has anyone any positive or negative experience of using squashfs on 
>>PowerPC as initrd?
>>
>>Our environment is PowerPC 405GP running 2.4.31 kernel. U-Boot is our 
>>bootloader. Any comparison with respect to CramFS?
>>    
>>
>
>I use squashfs and squashfs2. Both work just fine on PPC.
>
>They provide significantly better compression ration than cramfs, 
>although at the expense of some speed (mostly visible during initial 
>startup of big user-space app).
>
>  
>
