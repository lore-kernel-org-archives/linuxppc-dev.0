Return-Path: <SRS0=6H9d=RF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832BC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 01:23:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374072075B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 01:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374072075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44B7pg3cY7zDqVZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 12:23:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.217; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
X-Greylist: delayed 528 seconds by postgrey-1.36 at bilbo;
 Sat, 02 Mar 2019 12:22:06 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0217.hostedemail.com
 [216.40.44.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B7mt51H8zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 12:22:04 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id B1C6918017524
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 01:13:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2B028180A814A;
 Sat,  2 Mar 2019 01:13:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream38_1bc573e493721
X-Filterd-Recvd-Size: 2063
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf12.hostedemail.com (Postfix) with ESMTPA;
 Sat,  2 Mar 2019 01:13:10 +0000 (UTC)
Message-ID: <fc844ffdfbc028e635f46e7a4a301b4ea8748ee1.camel@perches.com>
Subject: Re: [PATCH 2/5] ocxl: Clean up printf formats
From: Joe Perches <joe@perches.com>
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Date: Fri, 01 Mar 2019 17:13:09 -0800
In-Reply-To: <20190227045741.21412-3-alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-27 at 15:57 +1100, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use %# instead of using a literal '0x'

<shrug>  I think it's better not to change this unless
the compilation unit already uses a mix of styles.

Overall, the kernel uses "0x%<hex type>" over "%#<hex type>"
by ~8:1

$ git grep -P '0x%\d*[hl]*x' | wc -l
27654
$ git grep -P '%#\d*[hl]*x' | wc -l
3454

> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
[]
> @@ -178,9 +178,9 @@ static int read_dvsec_vendor(struct pci_dev *dev)
>  	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_DLX_VERS, &dlx);
>  
>  	dev_dbg(&dev->dev, "Vendor specific DVSEC:\n");
> -	dev_dbg(&dev->dev, "  CFG version = 0x%x\n", cfg);
> -	dev_dbg(&dev->dev, "  TLX version = 0x%x\n", tlx);
> -	dev_dbg(&dev->dev, "  DLX version = 0x%x\n", dlx);
> +	dev_dbg(&dev->dev, "  CFG version = %#x\n", cfg);
> +	dev_dbg(&dev->dev, "  TLX version = %#x\n", tlx);
> +	dev_dbg(&dev->dev, "  DLX version = %#x\n", dlx);
[...]

