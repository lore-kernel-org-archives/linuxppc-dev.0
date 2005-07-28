Return-Path: <prashant.alange@gmail.com>
Message-ID: <6d145b4205072809505b101b48@mail.gmail.com>
Date: Thu, 28 Jul 2005 09:50:04 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Problem allocating large meory using m8260_cpm_hostalloc
Reply-To: Prashant Alange <prashant.alange@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,
I am having problem in allocating large memory using=20
m8260_cpm_hostalloc function in my driver. (Approx 256 Kbytes). I
tried increaing the NUM_CPM_HOST_PAGES macro in cpm_8260.h file to 64
but still it fails for 200K of memory request. This macro is used by
alloc_bootmem_pages() function. I have read that we should use this
function if we intend to have consecutive memory pages allocated.

Could anyone tell what I am missing here?
How can I allocate large memory in my driver using this hostalloc function?

Thanks for your time.

Prashant
