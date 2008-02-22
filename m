Return-Path: <alan.casey5@mail.dcu.ie>
Received: from hawk.dcu.ie (mail.dcu.ie [136.206.1.5])
	by ozlabs.org (Postfix) with ESMTP id 7E29CDDE9D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 04:43:54 +1100 (EST)
Date: Fri, 22 Feb 2008 17:23:21 +0000
Message-ID: <4726E9350007F0D6@hawk.dcu.ie>
In-Reply-To: <fa686aa40802211102i7f636447hfca0f8e1673042a5@mail.gmail.com>
From: "Alan Casey" <alan.casey5@mail.dcu.ie>
Subject: Re: Xilinx PowerPC
To: "Grant Likely" <grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: alan.casey5@mail.dcu.ie
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>-- Original Message --
>Date: Thu, 21 Feb 2008 12:02:21 -0700
>From: "Grant Likely" <grant.likely@secretlab.ca>
>To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
>Subject: Re: Xilinx PowerPC
>Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
>
>
>On Thu, Feb 21, 2008 at 10:50 AM, Stephen Neuendorffer
><stephen.neuendorffer@xilinx.com> wrote:
>>  >     Step 2).
>>  >              the code in arch/powerpc/???? is the devicetree equval=
ent
>>  to
>>  >              arch/ppc/platforms/4xx/xilinx_ml410.c
>>  http://git.xilinx.com/linux-2.6-xlnx.git contains a preliminary stab
at
>>  the bootcode for Virtex.  I've been using this for a while with
>>  ARCH=3Dpowerpc.  There isn't really much need for board specific plat=
form
>>  code: This should (I think) be handled by the device tree.  All of th=
is
>>  is still pretty preliminary at the moment however.  The big problem w=
ith
>>  the boot code in the Xilinx tree is that you need to be able to alloc=
ate
>>  memory in order to parse the device tree in order to figure out how m=
uch
>>  memory you have.  I just haven't rewritten the code to use libfdt, wh=
ich
>>  can query the device tree without memory allocation yet.  Grant has a=

>>  slightly different scheme in his tree, but it works as well.  General=
ly
>>  I've been more focused on avoiding u-boot, whereas Grant has been usi=
ng
>>  u-boot exclusively, I think.
>
>Actually, I'm not using u-boot at all.  I've reworked the 'raw' image
>target to use libfdt and properly initialize the cache and stuff.
>I'll be merging it in the .26 merge window.
>

Hi,

  Just wondering - is it possible to use U-Boot on the Xilinx XUPV2PRO
  board or any similar tools (such as libfdt?) to copy a Linux kernel and=


  ramdisk filesystem from a SystemACE card to memory, uncompress them and=


  boot the Linux kernel etc?? If so is there any notes/docs about how to
do
  this or similar online anywhere?

  Any info. appreciated,
  Regards&Thanks,
  Alan.
  
