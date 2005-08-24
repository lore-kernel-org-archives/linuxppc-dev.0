Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.204])
	by ozlabs.org (Postfix) with ESMTP id A842068100
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 01:23:02 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so170741rnf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 08:23:01 -0700 (PDT)
Date: Wed, 24 Aug 2005 09:12:14 -0600
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Message-ID: <20050824151214.GA4095@siegfried.thelikelysolution.ca>
References: <20050823170300.GA910@siegfried.thelikelysolution.ca>
	<430C7C3A.4000601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <430C7C3A.4000601@ru.mvista.com>
From: Grant Likely <glikely@gmail.com>
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

On Wed, Aug 24, 2005 at 05:55:06PM +0400, Andrei Konovalov wrote:
> Grant Likely wrote:
> >I want to know if xparameters_ml300.h is the exact output produced by
> >EDK or if stuff was changed before it was submitted to the mainline
> >tree.  (ie. all the stuff under the "linux redefines" comment block)
> 
> EDK can also generate the "Linux BSP".
> In this case EDK uses the scripts from (depending on your setup)
> /opt/xilinx/edk/7.1/sw/ThirdParty/bsp/linux_v2_00_b/data/
> In particular, linux_v2_1_0.tcl adds those "linux redefines"
> and renames xparameters.h to xparameters_ml300.h.
Ahh; I've been using the standalone option.  I didn't know about the tcl
script.
> 
> >Also, where can I get the bitstream/systemace file that matches
> >xparameters_ml300.h?
> 
> The most reliable way is to generate both (bitstream and
> xparameters_ml300.h) by yourself. :)
That's how I've gotten as far as I have :)

> 
> But if you are speaking about the xparameters_ml300.h in the community
> trees (linuxppc-2.4 and the 2.6 one from kernel.org), this file
> is for the reference design by Xilinx:
> 
> http://www.xilinx.com/ise/embedded/edk6_2docs/ml300_edk3.zip
Thanks!
g.
