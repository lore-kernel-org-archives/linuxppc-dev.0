Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x236.google.com (mail-qc0-x236.google.com
 [IPv6:2607:f8b0:400d:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3041A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 04:09:28 +1100 (AEDT)
Received: by qcvs11 with SMTP id s11so25700456qcv.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2015 09:09:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 2 Mar 2015 12:09:22 -0500
From: Tejun Heo <tj@kernel.org>
To: Martin Hicks <mort@bork.org>
Subject: Re: [PATCH] sata-fsl: Apply link speed limits
Message-ID: <20150302170922.GK17694@htj.duckdns.org>
References: <20150219200547.GA25730@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150219200547.GA25730@darwin.bork.org>
Cc: Scott Wood <scottwood@freescale.com>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2015 at 03:05:47PM -0500, Martin Hicks wrote:
> 
> 
> The driver was ignoring limits requested by libata.force.  The output
> would look like:
> 
> fsl-sata ffe18000.sata: Sata FSL Platform/CSB Driver init
> ata1: FORCE: PHY spd limit set to 1.5Gbps
> ata1: SATA max UDMA/133 irq 74
> ata1: Signature Update detected @ 0 msecs
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
> 
> Signed-off-by: Martin Hicks <mort@bork.org>

Applied to libata/for-4.0-fixes.

Thanks.

-- 
tejun
