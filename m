Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 435F4DE4AB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:41:18 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1233497ana.81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 15:41:17 -0700 (PDT)
Message-ID: <fa686aa40803171541t6357d304i2e7e5292f084d09d@mail.gmail.com>
Date: Mon, 17 Mar 2008 16:41:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: powerpc: cuImage.* creation error
In-Reply-To: <20080317200754.GA7383@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
	<20080317200754.GA7383@windriver.com>
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 2:07 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> In message: powerpc: cuImage.* creation error
>
>  @@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)                     += cuImage.tqm8540
>   image-$(CONFIG_TQM8541)                        += cuImage.tqm8541
>   image-$(CONFIG_TQM8555)                        += cuImage.tqm8555
>   image-$(CONFIG_TQM8560)                        += cuImage.tqm8560
>  -image-$(CONFIG_SBC8548)                        += cuImage.tqm8548
>  -image-$(CONFIG_SBC8560)                        += cuImage.tqm8560
>  +image-$(CONFIG_SBC8548)                        += cuImage.sbc8548
>  +image-$(CONFIG_SBC8560)                        += cuImage.sbc8560

No, the suffix in the cuImage targets has a 1:1 relationship with dts
files in arch/powerpc/boot/dts/.  If a file doesn't exist there, then
the target cannot be built.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
