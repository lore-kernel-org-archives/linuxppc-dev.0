Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 05B2968085
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 23:43:58 +1000 (EST)
Message-ID: <430C7C3A.4000601@ru.mvista.com>
Date: Wed, 24 Aug 2005 17:55:06 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <20050823170300.GA910@siegfried.thelikelysolution.ca>
In-Reply-To: <20050823170300.GA910@siegfried.thelikelysolution.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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

Grant Likely wrote:
> Does anyone know the origin of xparameter_ml300.h?  The
> Xilinx EDK generates an xparameters.h file for each design, but the
> structure of the file changes between releases.
> 
> I want to know if xparameters_ml300.h is the exact output produced by
> EDK or if stuff was changed before it was submitted to the mainline
> tree.  (ie. all the stuff under the "linux redefines" comment block)

EDK can also generate the "Linux BSP".
In this case EDK uses the scripts from (depending on your setup)
/opt/xilinx/edk/7.1/sw/ThirdParty/bsp/linux_v2_00_b/data/
In particular, linux_v2_1_0.tcl adds those "linux redefines"
and renames xparameters.h to xparameters_ml300.h.

> Also, where can I get the bitstream/systemace file that matches
> xparameters_ml300.h?

The most reliable way is to generate both (bitstream and
xparameters_ml300.h) by yourself. :)

But if you are speaking about the xparameters_ml300.h in the community
trees (linuxppc-2.4 and the 2.6 one from kernel.org), this file
is for the reference design by Xilinx:

http://www.xilinx.com/ise/embedded/edk6_2docs/ml300_edk3.zip

> I've got a custom ml300 image that I'm regression
> testing against, but I'd like to also test against some form of 'stock'
> image. :)
> 
> Thanks,
> g.

Thanks,
Andrei
