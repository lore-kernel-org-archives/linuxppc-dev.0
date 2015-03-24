Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x22d.google.com (mail-qg0-x22d.google.com
 [IPv6:2607:f8b0:400d:c04::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C6E21A0271
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 04:51:27 +1100 (AEDT)
Received: by qgfa8 with SMTP id a8so888921qgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 10:51:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 24 Mar 2015 13:51:16 -0400
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] sata_dwc_460ex: re-use hsdev->dev instead of
 dwc_dev
Message-ID: <20150324175116.GL3880@htj.duckdns.org>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425415282-3750-3-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425415282-3750-3-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-ide@vger.kernel.org,
 rsarmah@amcc.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 03, 2015 at 10:41:22PM +0200, Andy Shevchenko wrote:
> This patch re-uses hsdev->dev which is allocated on heap. Therefore, the
> private structure, which is global variable, is reduced by one field.
> 
> In one case ap->dev is used and there it seems to be right decision.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied 1-2 to libata/for-4.1.

Thanks.

-- 
tejun
