Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C5D29DDEED
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 17:41:31 +1000 (EST)
To: Peter Korsgaard <jacmet@sunsite.dk>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] bootwrapper: support u-boot multi component images
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
References: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
Date: Mon, 22 Sep 2008 09:41:28 +0200
Sender: wd@denx.de
Message-Id: <20080922074128.A66F22487F@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Peter Korsgaard,

In message <1221814210-4738-1-git-send-email-jacmet@sunsite.dk> you wrote:
> From: peter Korsgaard <jacmet@sunsite.dk>
> 
> Support uImage.<platform>, which are U-Boot multi component images
> containing a kernel, dtb and possibly an initrd.

NAK.

Please do not add such a patch to mainline.

> +   uImage.%:		U-Boot multi component image. Similar to uImage,
> +			except device tree blob is embedded inside the
> +			image together with the kernel (and potentially
> +			an initrd).

The use of the old multi-file image format in U-Boot  is  deprecated.
It  has  some  severe  limitations,  and we have a much more flexible
solution now.

Please use FIT images instead (see doc/uImage.FIT/*).

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
 The software required `Windows 95 or better', so I installed Linux.
