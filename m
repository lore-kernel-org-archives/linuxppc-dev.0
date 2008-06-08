Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 02211DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Jun 2008 13:38:37 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so349090anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 07 Jun 2008 20:38:29 -0700 (PDT)
Message-ID: <fa686aa40806072038h20a9dfd6kf32148cb1c4417ce@mail.gmail.com>
Date: Sat, 7 Jun 2008 21:38:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sam Karp" <sam.d.karp@gmail.com>
Subject: Re: Linux w/o UBoot from Linear Flash
In-Reply-To: <800687fe0806071529j16cc360bub252c492975368ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <800687fe0806071529j16cc360bub252c492975368ea@mail.gmail.com>
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

On Sat, Jun 7, 2008 at 4:29 PM, Sam Karp <sam.d.karp@gmail.com> wrote:
> I currently have a linux ramdisk image (zImage.initrd.elf) stored in
> linear flash.  I also have a bit file with the xilinx EDK generated
> bootloader in platform flash on an ML403.   Is it neccessary to have
> uboot with the linux kernel to be able to boot automatically or can i
> simply alter the xilinx bootloader (if needed at all? )

U-Boot in not necessary.  You can modify the xilinx bootloader to load
an elf file into ram and jump into it.  When you migrate to using
arch/powerpc, you can use the simpleImage target which can be loaded
anywhere into ram before jumping to it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
