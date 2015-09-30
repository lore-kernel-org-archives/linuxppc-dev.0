Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8792A1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 05:08:49 +1000 (AEST)
Subject: Re: [PATCH v11 1/6] genalloc:support memory-allocation with
 bytes-alignment to genalloc
To: Zhao Qiang <qiang.zhao@freescale.com>, scottwood@freescale.com
References: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lauraa@codeaurora.org, X.xie@freescale.com, benh@kernel.crashing.org,
 leoli@freescale.com, paulus@samba.org
From: Laura Abbott <labbott@redhat.com>
Message-ID: <560C333B.8080306@redhat.com>
Date: Wed, 30 Sep 2015 12:08:43 -0700
MIME-Version: 1.0
In-Reply-To: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 07:09 PM, Zhao Qiang wrote:
> Bytes alignment is required to manage some special RAM,
> so add gen_pool_first_fit_align to genalloc,
> meanwhile add gen_pool_alloc_data to pass data to
> gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)
>
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>

Reviewed-by: Laura Abbott <labbott@redhat.com>
