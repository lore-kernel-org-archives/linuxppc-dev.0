Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com
 [IPv6:2607:f8b0:400d:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7045F1A0A01
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 22:23:01 +1000 (AEST)
Received: by qkgx75 with SMTP id x75so14898569qkg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 05:22:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 Apr 2015 08:22:26 -0400
From: Tejun Heo <tj@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 2/3] Remove celleb-only SCC PATA drivers
Message-ID: <20150414122226.GM2596@htj.duckdns.org>
References: <1428989326-7637-1-git-send-email-dja@axtens.net>
 <1428989326-7637-2-git-send-email-dja@axtens.net>
 <7604591.MsqiRRA37E@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7604591.MsqiRRA37E@amdc1032>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 14, 2015 at 01:58:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> If Tejun & Dave are OK with it this patch can go through libata tree.
> Otherwise you will need to split it on separate libata/IDE patches.

I really don't care which tree this goes through.  Dave, if you wanna
take it, please feel free to add my acked-by.  If not, I'll route it.

Thanks.

-- 
tejun
