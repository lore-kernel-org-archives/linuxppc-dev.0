Return-Path: <webmail-nossl.web4all.fr@ns1.w4a.fr>
Received: from ns1.w4a.fr (ns27106.ovh.net [91.121.84.22])
	by ozlabs.org (Postfix) with ESMTP id AA278DDF13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Dec 2008 01:16:10 +1100 (EST)
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: how to make a PowerPC =?UTF-8?Q?executable=3F=3F?=
MIME-Version: 1.0
Date: Tue, 16 Dec 2008 14:54:04 +0100
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
In-Reply-To: <200812161326.27732.laurentp@cse-semaphore.com>
References: <9c4da51b0812160420r223a294j3bbe481c8b1b81fa@mail.gmail.com>
	<200812161326.27732.laurentp@cse-semaphore.com>
Message-ID: <f8cd31c9eef84d00ab524f750c25329a@91.121.53.53>
Content-Type: text/plain; charset="UTF-8"
Cc: umesh krishnan <umeshdelhi@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




On Tue, 16 Dec 2008 13:26:27 +0100, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
> Hi Umesh,
> 
> On Tuesday 16 December 2008 13:20:57 umesh krishnan wrote:
>> Hi group,
>>
>> I have a little problem out here. I have some codes with me which i have
> to
>> run on PowerPC based target. I dont have that particular hardware with
> me.
>> Can anyone suggest a cross-compiler or an emulator, so that i can
> compile
>> my codes in linux and make a PowerPC executable from here. I tried qemu
> but
>> it didn't work.
>>
>> It was making a 386 executable rather than a powerpc executable. The
> cross
>> compiler option 'powerpc-750-unknown-gnu-gcc' was not coming.. Instead
> it
>> was to build a 386 based executable. I did everything following the
>> "Emulation and cross-development for PowerPC" page in the link
>> http://www.ibm.com/developerworks/library/pa-emulation.html ..
>> qemu-ppc emulator was installed correctly but the crosstool was the
>> problem. Please help me out. I cant afford a VxWorks (For the workbench
> or
>> the Tornado compiler). Any way out..
>> Can i sit on windows and do something? Is there any emulator like that?
>> I'm fairly new to this field. Kindly guide me through..
> 
> Building a gcc-based cross toolchain isn't that difficult nowadays. The
> crosstool scripts (available at http://www.kegel.com/crosstool/) should
> make
> your life much easier.

If you want to build a "native" powerpc compiler that run inside a qemu
based linux system (so that you can also test the binary on this target),
you could also have a look at http://impactlinux.com/fwl/

JC

> 
> Best regards,
> 
> --
> Laurent Pinchart
> CSE Semaphore Belgium
> 
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
> 
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
