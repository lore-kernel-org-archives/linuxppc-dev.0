Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 1BE17DDF81
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 23:29:26 +1100 (EST)
Message-ID: <460277DE.8080808@ru.mvista.com>
Date: Thu, 22 Mar 2007 15:34:38 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Trevor Barton <tmb@isotek.co.uk>
Subject: Re: Arch: powerpc or ppc?
References: <4602578C.4010401@isotek.co.uk>
In-Reply-To: <4602578C.4010401@isotek.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Trevor,

There is (minimalistic) support for Xilinx Virtex 4 under ppc.
Unless you plan to move those chips to powerpc by yourself,
you should use ppc.

Thanks,
Andrei

Trevor Barton wrote:
> I've just started bringing Linux up on a Xilinx Virtex 4 FPGA with a 
> PPC405 core.  I'm using 2.6.15, and a crosstools-built toolchain from an 
> x86 running Linux.  The choice of kernel version was because crosstools 
> identified it as a working combination and I can see no reason to choose 
> anything different at the moment.
> 
> I'm a bit confused about the difference between the ppc and powerpc 
> architecture trees in the kernel.  I've been using the ppc tree because 
> that seems to have the requisite sources in it (I'm basing it on the 
> ML300 code which seems to be the thing to do), and also because that was 
> the only powerpc-related  tree in earlier kernels.  I can't seem to find 
> any documentation as to where the powerpc tree appeared from and why.
> 
> Can anyone confirm that I should still be using the ppc tree?  Or even 
> better, point me to some documentation regarding them both?
> 
> Actually, while I'm at it, pointers to anything useful regarding the 2.6 
> kernel and the Virtex 4 would be helpful.  I've found a reasonable 
> amount of stuff myself, but as these things usually go I'll only find 
> the best documentation after I've solved the problems myself and 
> therefore know what I'm looking for!
> 
> Thanks in advance,
> Trevor Barton
> 
