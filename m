Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 021CADDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 13:28:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so29119nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 20:28:12 -0700 (PDT)
Message-ID: <fa686aa40708212028n6dfe02fend98298fc945f063e@mail.gmail.com>
Date: Tue, 21 Aug 2007 21:28:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "wolfgang.reissnegger@xilinx.com" <wolfgang.reissnegger@xilinx.com>
Subject: Re: [PATCH 1/3] Add generic configuration option to enable all xilinx
	drivers.
In-Reply-To: <20070822005048.BD4E4D800B8@mail60-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070822005048.BD4E4D800B8@mail60-blu.bigfish.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/21/07, wolfgang.reissnegger@xilinx.com
<wolfgang.reissnegger@xilinx.com> wrote:
> From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> In the future, this will be used to provide similar configuration
> for PowerPC and Microblaze.

I'm not convinced that this change is worth it since there is only one
in-tree driver that uses it.  I'd maintain it separately in your tree
until other drivers or the microblaze stuff is ready for merging.

<snip>

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 518d5d3..e5bc9af 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -219,3 +219,13 @@ config THINKPAD_ACPI_INPUT_ENABLED
>
>
>  endif # MISC_DEVICES
> +endmenu

Umm, this looks wrong.  Where'd the 'endmenu' come from?

Cheers,
g

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
