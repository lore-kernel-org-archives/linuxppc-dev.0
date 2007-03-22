Return-Path: <tmb@isotek.co.uk>
Received: from pih-relay06.plus.net (pih-relay06.plus.net [212.159.14.133])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36D31DDF6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 22:28:44 +1100 (EST)
Received: from [81.174.145.144] (helo=cow.tmjabarton.plus.com)
	by pih-relay06.plus.net with esmtp (Exim) id 1HUKLj-0005k0-KM
	for linuxppc-embedded@ozlabs.org; Thu, 22 Mar 2007 10:16:51 +0000
Received: from [127.0.0.1] (squirrel.tmjabarton.plus.com [192.168.10.1])
	by cow.tmjabarton.plus.com (8.12.11/8.12.11) with ESMTP id
	l2MAGoab027207
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Mar 2007 10:16:51 GMT
Message-ID: <4602578C.4010401@isotek.co.uk>
Date: Thu, 22 Mar 2007 10:16:44 +0000
From: Trevor Barton <tmb@isotek.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Arch: powerpc or ppc?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've just started bringing Linux up on a Xilinx Virtex 4 FPGA with a 
PPC405 core.  I'm using 2.6.15, and a crosstools-built toolchain from an 
x86 running Linux.  The choice of kernel version was because crosstools 
identified it as a working combination and I can see no reason to choose 
anything different at the moment.

I'm a bit confused about the difference between the ppc and powerpc 
architecture trees in the kernel.  I've been using the ppc tree because 
that seems to have the requisite sources in it (I'm basing it on the 
ML300 code which seems to be the thing to do), and also because that was 
the only powerpc-related  tree in earlier kernels.  I can't seem to find 
any documentation as to where the powerpc tree appeared from and why.

Can anyone confirm that I should still be using the ppc tree?  Or even 
better, point me to some documentation regarding them both?

Actually, while I'm at it, pointers to anything useful regarding the 2.6 
kernel and the Virtex 4 would be helpful.  I've found a reasonable 
amount of stuff myself, but as these things usually go I'll only find 
the best documentation after I've solved the problems myself and 
therefore know what I'm looking for!

Thanks in advance,
Trevor Barton

-- 
Isotek Electronics Ltd., 9 Clayton Wood Bank, Leeds, LS16 6QZ, UK.
Tel: +44 (113) 275 1339  Fax: +44 (113) 224 9827 Web: www.isotek.co.uk
Views expressed are my own and not necessarily those of Isotek 
Electronics Ltd.
