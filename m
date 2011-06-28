Return-Path: <mike@mikebwilliams.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F414CB6F5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 01:12:15 +1000 (EST)
Received: by fxe23 with SMTP id 23so322346fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 08:12:10 -0700 (PDT)
Received: by fxe23 with SMTP id 23so322279fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 08:12:07 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 28 Jun 2011 11:12:07 -0400
Message-ID: <BANLkTiki2MsvuOSrgDeWAkazrUZ7m5M2cw@mail.gmail.com>
Subject: Re: [PATCH v13 09/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
From: Mike Williams <mike@mikebwilliams.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: tmarri@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 03, 2011 at 04:17:24PM -0700, tmarri at apm.com wrote:
> +choice
> + prompt "DWC Mode Selection"
> + depends on USB_DWC_OTG
> + default DWC_HOST_ONLY
> + help
> + =A0Select the DWC Core in OTG, Host only, or Device only mode.
> +
> +config DWC_HOST_ONLY
> + bool "DWC Host Only Mode"
> +
> +config DWC_OTG_MODE
> + bool "DWC OTG Mode"
> + select USB_GADGET_SELECTED

It appears this depends on host support? I get compile errors when I
have this selected and no host support enabled.

> +
> +config DWC_DEVICE_ONLY
> + bool "DWC Device Only Mode"
> + select USB_GADGET_SELECTED
> +
> +endchoice

Thanks,
Mike
