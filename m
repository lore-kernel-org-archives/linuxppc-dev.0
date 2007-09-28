Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id A13A9DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 04:06:25 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so686373ele
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 11:06:24 -0700 (PDT)
Message-ID: <9e4733910709281106x15e0fd2bl23e4e84102f631b5@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:06:23 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: Nick <ndroogh@rogers.com>
Subject: Re: Help with Device tree setup and booting kernel
In-Reply-To: <46FD311D.2050100@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46FD311D.2050100@rogers.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/28/07, Nick <ndroogh@rogers.com> wrote:
> Hi everyone,
>
> I am having trouble booting a 2.6.23-rc6 kernel with a device tree.  My
> board is a MPC5200b base board with 128 Megs of DDR memeory.
> My UBoot (1.3.0-rc2)seems to be doing what is should be doing.  I
> download the .dtb file to 00800000 and the uImage to 00200000
> I get the following:
>
> => bootm 00200000 - 00800000
> ## Booting image at 00200000 ...
>   Image Name:   Linux-2.6.23-rc6-gea60adb5-dirty
>   Created:      2007-09-28   9:49:16 UTC
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1212342 Bytes =  1.2 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>   Booting using the fdt at 0x800000
>   Loading Device Tree to 007fc000, end 007fefff ... OK
>
> My board is now hung, with no more output to the console.  My board does
> work.  I have been running 2.6.19 for more than a year but I had to
> upgrade.

Does the machine name in the root of your device tree match the name
the code in arch/powerpc/platforms/52xx/whatever.c? You get what you
are seeing if the names don't match.

You also get this error if the kernel is looking someplace where the
device tree isn't.
Do these need to match? 007fc000 and 00800000

>
> I used the latest kernel code from DENX.  Is this a good distribution or
> is there a better one somewhere else?  I can send my dts file and the
> kernel .config file if anyone is willing to help
>
> Thanks in advance,
>
> Nick
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Jon Smirl
jonsmirl@gmail.com
