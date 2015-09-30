Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4C2A1A061E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 05:14:39 +1000 (AEST)
Subject: Re: [PATCH v11 2/6] genalloc:support allocating specific region
To: Zhao Qiang <qiang.zhao@freescale.com>, scottwood@freescale.com
References: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
 <1443492561-11538-2-git-send-email-qiang.zhao@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lauraa@codeaurora.org, X.xie@freescale.com, benh@kernel.crashing.org,
 leoli@freescale.com, paulus@samba.org
From: Laura Abbott <labbott@redhat.com>
Message-ID: <560C349B.4090208@redhat.com>
Date: Wed, 30 Sep 2015 12:14:35 -0700
MIME-Version: 1.0
In-Reply-To: <1443492561-11538-2-git-send-email-qiang.zhao@freescale.com>
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
> Add new algo for genalloc, it reserve a specific region of
> memory matching the size requirement (no alignment constraint)
>
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>

Reviewed-by: Laura Abbott <labbott@redhat.com>
