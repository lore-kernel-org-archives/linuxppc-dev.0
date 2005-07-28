Return-Path: <bgoodman@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 28 Jul 2005 13:29:13 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901011B00CC@EMPBEDEX.empirix.com>
From: "Goodman, Brad" <bgoodman@empirix.com>
To: "Prashant Alange" <prashant.alange@gmail.com>,
	<Linuxppc-embedded@ozlabs.org>
Subject: RE: Problem allocating large meory using m8260_cpm_hostalloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think you have to increase MAX_ORDER in linux/mmzone.h

This number means you can allocate a maximum of 2^(MAX_ORDER-1)
contiguous pages.

Brad Goodman


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Prashant
Alange
Sent: Thursday, July 28, 2005 12:50 PM
To: Linuxppc-embedded@ozlabs.org
Subject: Problem allocating large meory using m8260_cpm_hostalloc

Hi everyone,
I am having problem in allocating large memory using=20
m8260_cpm_hostalloc function in my driver. (Approx 256 Kbytes). I
tried increaing the NUM_CPM_HOST_PAGES macro in cpm_8260.h file to 64
but still it fails for 200K of memory request. This macro is used by
alloc_bootmem_pages() function. I have read that we should use this
function if we intend to have consecutive memory pages allocated.

Could anyone tell what I am missing here?
How can I allocate large memory in my driver using this hostalloc
function?

Thanks for your time.

Prashant
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
