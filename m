Message-Id: <v04003a00b57f9c3f856d@[24.66.67.194]>
In-Reply-To: <Pine.HPX.4.10.10006281021160.5670-100000@gra-ux1.iram.es>
References: <395998E0.65DD0D9B@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 28 Jun 2000 07:18:09 -0500
To: Gabriel Paubert <paubert@iram.es>, Steven Hanley <sjh@wibble.net>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: problem with compressing the kernel
Cc: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:05 AM -0500 6/28/2000, Gabriel Paubert wrote:
>On Wed, 28 Jun 2000, Steven Hanley wrote:
>
>> you seem to be confused anyway, yes the kernel is compressed for x86
>> machiens (it is however not compressed for other architectures, my ppc
>> box uses a normal uncompresased vmlinux image.
>
>Perhaps on a Mac, but _all_ the kernels I have ever built for _all_ my PPC
>machines have _always_ been compressed, without a _single_ exception.
>Browsing the tree you'll easily find that there the kernel image is
>compressed (maybe depending on some CONFIG option) on:
>
>- alpha
>- arm
>- i386
>- m68k
>- ppc

Just to confuse the issue a bit, I'd like to note that on Mac68k (maybe
m68k in general, I don't recall), you *can* take an uncompressed kernel
image, run it through gzip or bzip2, and boot with it. Sometimes always
needing a seperate bootloader can be a luxury. :)


Cheers - Tony :)


--
Tony Mantler       Renaissance Nerd Extraordinaire     nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada                     http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
