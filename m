Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B36C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 04:40:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CDD60C4B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 04:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4CDD60C4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HWVms0lTnz3cM7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 15:40:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HWVmK4L5cz3bT7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2021 15:39:43 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1695D68BEB; Sat, 16 Oct 2021 06:39:37 +0200 (CEST)
Date: Sat, 16 Oct 2021 06:39:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 02/13] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20211016043936.GB27339@lst.de>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-3-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: nvdimm@lists.linux.dev, vigneshr@ti.com, linux-nvme@lists.infradead.org,
 paulus@samba.org, miquel.raynal@bootlin.com, ira.weiny@intel.com, hch@lst.de,
 dave.jiang@intel.com, sagi@grimberg.me, minchan@kernel.org,
 vishal.l.verma@intel.com, ngupta@vflare.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, dan.j.williams@intel.com, axboe@kernel.dk,
 geoff@infradead.org, linux-kernel@vger.kernel.org, jim@jtan.com,
 senozhatsky@chromium.org, richard@nod.at, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Thanks,

applied to nvme-5.16.
