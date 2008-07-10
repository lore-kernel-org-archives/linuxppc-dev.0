Return-Path: <neerajg@cdac.in>
Received: from mx2.cdac.in (mx1.cdac.in [203.199.132.35])
	by ozlabs.org (Postfix) with ESMTP id DC53ADDE06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 17:22:45 +1000 (EST)
Received: from mailhub.cdac.in (mailhub [196.1.109.254])by mailhub.cdac.in
	(8.13.4/8.13.4) with ESMTP id m6A7MeTA001150for
	<linuxppc-embedded@ozlabs.org>; Thu, 10 Jul 2008 12:52:40 +0530
Message-ID: <4875B95C.8020809@cdac.in>
Date: Thu, 10 Jul 2008 12:55:16 +0530
From: neeraj garg <neerajg@cdac.in>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, John.Linn@xilinx.com,
	marco.stornelli@coritel.it
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)
References: <48744475.2080605@cdac.in> <20080709143318.GB26524@secretlab.ca>
In-Reply-To: <20080709143318.GB26524@secretlab.ca>
Content-Type: multipart/alternative;
	boundary=------------060401040401000700020603
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060401040401000700020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Yes I am using ARCH=ppc (actual line is $make ARCH=ppc 
CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have 
placed ramdisk.image.gz in arch/ppc/boot/images. In case of ARCH=powerpc 
I cannot find processor type 405 , in make menuconfig. Thats why i am 
using ARCH=ppc.

And when I give kernel command string as init=/bin/sh , it says :
 >Failed to execute /bin/sh.  Attempting defaults...
[    3.744035] Kernel panic - not syncing: No init found.  Try passing 
init= option to kernel.
[    3.768073] Rebooting in 30 seconds..

--init is present in sbin/init which is a soft link to ../bin/busybox

--I used powepc-405-gnu-readelf -h bin/sh to verify that it is compiled 
for powerpc itself.

Any other suggestions ?

-----------------------------------------------------
Neeraj Garg




Grant Likely wrote:
> On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj garg wrote:
>   
>> Hi,
>>
>> I am trying to boot ML405 with Linux source code downloaded from  
>> http://www.git.xilinx.com . My cross compiler tool chain version is  
>> gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded RAMDISK  
>> from same url (http://www.git.xilinx.com). When I download  
>> zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is  
>> uncompressed, I get following messages :
>>
>>     
> <snip>
>   
>>                                           [    3.736691] Failed to  
>> execute /sbin/init.  Attempting defaults...
>> [    3.748073] Kernel panic - not syncing: No init found.  Try passing  
>> init= option to kernel.
>> [    3.772040] Rebooting in 180 seconds..[  183.487314]   Signal: 8
>>
>>     
>
> Try changing the kernel parameters line to specify init=/bin/sh and see
> what happens.
>
> g.
>   

--------------060401040401000700020603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
Yes I am using ARCH=ppc (actual line is $make ARCH=ppc
CROSS_COMPILE=powerpc-405-linux-gnu- zImage.initrd ) for this I have
placed ramdisk.image.gz in arch/ppc/boot/images. In case of
ARCH=powerpc I cannot find processor type 405 , in make menuconfig.
Thats why i am using ARCH=ppc.<br>
<br>
And when I give kernel command string as init=/bin/sh , it says : <br>
&gt;Failed to execute /bin/sh.&nbsp; Attempting defaults...<br>
[&nbsp;&nbsp;&nbsp; 3.744035] Kernel panic - not syncing: No init found.&nbsp; Try passing
init= option to kernel.<br>
[&nbsp;&nbsp;&nbsp; 3.768073] Rebooting in 30 seconds..<br>
<br>
--init is present in sbin/init which is a soft link to ../bin/busybox<br>
<br>
--I used powepc-405-gnu-readelf -h bin/sh to verify that it is compiled
for powerpc itself.<br>
<br>
Any other suggestions ?<br>
<br>
<pre class="moz-signature" cols="72">-----------------------------------------------------
Neeraj Garg

</pre>
<br>
<br>
Grant Likely wrote:
<blockquote cite="mid:20080709143318.GB26524@secretlab.ca" type="cite">
  <pre wrap="">On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj garg wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,

I am trying to boot ML405 with Linux source code downloaded from  
<a class="moz-txt-link-freetext" href="http://www.git.xilinx.com">http://www.git.xilinx.com</a> . My cross compiler tool chain version is  
gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded RAMDISK  
from same url (<a class="moz-txt-link-freetext" href="http://www.git.xilinx.com">http://www.git.xilinx.com</a>). When I download  
zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is  
uncompressed, I get following messages :

    </pre>
  </blockquote>
  <pre wrap=""><!---->&lt;snip&gt;
  </pre>
  <blockquote type="cite">
    <pre wrap="">                                          [    3.736691] Failed to  
execute /sbin/init.  Attempting defaults...
[    3.748073] Kernel panic - not syncing: No init found.  Try passing  
init= option to kernel.
[    3.772040] Rebooting in 180 seconds..[  183.487314]   Signal: 8

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Try changing the kernel parameters line to specify init=/bin/sh and see
what happens.

g.
  </pre>
</blockquote>
</body>
</html>

--------------060401040401000700020603--
