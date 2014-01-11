Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64D7C2C0089
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 11:27:53 +1100 (EST)
Received: by mail-la0-f43.google.com with SMTP id n7so3728874lam.16
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jan 2014 16:27:49 -0800 (PST)
Message-ID: <52D09E19.9030302@cogentembedded.com>
Date: Sat, 11 Jan 2014 04:27:53 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>, benh@kernel.crashing.org
Subject: Re: [PATCH 4/8] IBM Akebono: Add support to the OHCI platform driver
 for PPC476GTR
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-4-git-send-email-alistair@popple.id.au>
In-Reply-To: <1385086116-10972-4-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
 Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 11/22/2013 05:08 AM, Alistair Popple wrote:

> The IBM Akebono board uses the PPC476GTR SoC which has a OHCI
> compliant USB host interface. This patch adds support for it to the
> OHCI platform driver.

> As we use device tree to pass platform specific data instead of
> platform data we remove the check for platform data and instead
> provide reasonable defaults if no platform data is present. This is
> similar to what is currently done in ehci-platform.c.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org

    Greg, why this patch hasn't been merged? Because it wasn't addressed to 
you (but BenH)? The other, ehci-platform.c patch didn't even get posted to 
linux-usb that time, but this one?

WBR, Sergei
