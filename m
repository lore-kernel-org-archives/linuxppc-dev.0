Return-Path: <peter.ryser@xilinx.com>
Received: from mail20-kan-R.bigfish.com (mail-kan.bigfish.com [63.161.60.29])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CD680683FE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 20:38:08 +1000 (EST)
Received: from mail20-kan.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail20-kan-R.bigfish.com (Postfix) with ESMTP id 1395A31E187
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 10:10:11 +0000 (UTC)
Received: from newsgate.xilinx.com (unknown-60-204.xilinx.com [149.199.60.204])
	by mail20-kan.bigfish.com (Postfix) with ESMTP id C3C863196FC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 10:10:10 +0000 (UTC)
Received: from cliff.xilinx.com (cliff [149.199.38.103])
	by newsgate.xilinx.com (8.11.6p2/8.11.6) with ESMTP id j8SAAAe24683
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 03:10:10 -0700 (PDT)
Received: from XSJ-EXCHVS1.xlnx.xilinx.com (localhost [127.0.0.1])
	by cliff.xilinx.com (8.12.9/8.11.6) with ESMTP id j8SAA9r0000603
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 03:10:09 -0700 (PDT)
Message-ID: <433A68FE.8030907@xilinx.com>
Date: Wed, 28 Sep 2005 02:57:18 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050823170300.GA910@siegfried.thelikelysolution.ca>
	<430C7C3A.4000601@ru.mvista.com>
In-Reply-To: <430C7C3A.4000601@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please have a look at XAPP765 
(http://direct.xilinx.com/bvdocs/appnotes/xapp765.pdf) and the EDK 
documentation to see how this works. The latest MLD to create a BSP for 
a linuxppc-2.4 kernel is linuxppc_mvl31_v1_01_a. linuxppc_mvl31_v1_00_a 
works too but everything else is not up-to-date.

The documentation and tutorials for the ML310 board are also an 
excellent source of information how to get a Linux kernel up and running 
on Virtex-II Pro (see http://www.xilinx.com/ml310).

The reference design for the ML403 is yet another source of information 
(http://www.xilinx.com/ml403). Have a look at the reference design users 
guide.

Using the MLD (tcl script) is much less error-prone than any other 
method that involves changing the files by hand. It's a little bit of a 
learning curve but once mastered it just works.

- Peter



Andrei Konovalov wrote:

> Grant Likely wrote:
>
>> Does anyone know the origin of xparameter_ml300.h?  The
>> Xilinx EDK generates an xparameters.h file for each design, but the
>> structure of the file changes between releases.
>>
>> I want to know if xparameters_ml300.h is the exact output produced by
>> EDK or if stuff was changed before it was submitted to the mainline
>> tree.  (ie. all the stuff under the "linux redefines" comment block)
>
>
> EDK can also generate the "Linux BSP".
> In this case EDK uses the scripts from (depending on your setup)
> /opt/xilinx/edk/7.1/sw/ThirdParty/bsp/linux_v2_00_b/data/
> In particular, linux_v2_1_0.tcl adds those "linux redefines"
> and renames xparameters.h to xparameters_ml300.h.
>
>> Also, where can I get the bitstream/systemace file that matches
>> xparameters_ml300.h?
>
>
> The most reliable way is to generate both (bitstream and
> xparameters_ml300.h) by yourself. :)
>
> But if you are speaking about the xparameters_ml300.h in the community
> trees (linuxppc-2.4 and the 2.6 one from kernel.org), this file
> is for the reference design by Xilinx:
>
> http://www.xilinx.com/ise/embedded/edk6_2docs/ml300_edk3.zip
>
>> I've got a custom ml300 image that I'm regression
>> testing against, but I'd like to also test against some form of 'stock'
>> image. :)
>>
>> Thanks,
>> g.
>
>
> Thanks,
> Andrei
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
