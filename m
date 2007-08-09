Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 245B3DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 05:05:53 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so281795nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Aug 2007 12:05:52 -0700 (PDT)
Message-ID: <fa686aa40708091205u4217deder658b1135ff202278@mail.gmail.com>
Date: Thu, 9 Aug 2007 13:05:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>
Subject: Re: [PATCH] Generic configuration selector for Xilinx devices
In-Reply-To: <20070806225403.B430E550060@mail33-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225403.B430E550060@mail33-cpk.bigfish.com>
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

On 8/6/07, Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> wrote:
> This is intended to make visible all device driver options for
> both powerpc and microblaze systems.
>
> Thanks,
>    Wolfgang
>
>
> Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>


This patch adds a new directory "drivers/misc/xilinx" with exactly *1*
file in it; A Kconfig file.  Just put the new XILINX_DRIVERS Kconfig
option into drivers/misc/Kconfig.  If there is ever enough Xilinx
stuff to warrant a separate drivers/misc/xilinx directory, then the
Kconfig entry can be moved.

<snip>
> +++ b/drivers/misc/xilinx/Kconfig
> @@ -0,0 +1,9 @@
> +#
> +# Xilinx devices and common device driver infrastructure
> +#
> +
> +config XILINX_DRIVERS
> +  bool
> +  help
> +    Enable visibility of all Xilinx device drivers

Drop the help text; XILINX_DRIVERS won't show up in the menu, so it is
pointless.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
