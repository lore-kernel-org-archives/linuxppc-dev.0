Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A57431A2AC9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 09:59:35 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 795DC1401CB
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 09:59:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 7 Sep 2015 09:59:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 429583578053
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 09:59:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t86NxEcH55181490
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 09:59:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t86Nwwak012555
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 09:58:58 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] cxl: abort cxl_pci_enable_device_hook() if PCI channel is
 offline
In-reply-to: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Mon, 07 Sep 2015 09:58:33 +1000
Message-Id: <1441583849-sup-2488@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from andrew.donnellan's message of 2015-09-04 16:20:24 +1000:
> +    if (!cxl_adapter_link_ok(afu->adapter))
> +        dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
> +        return false;

Based on the indentation it looks like you meant to add some curly
brackets here.

-Ian
