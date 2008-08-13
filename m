Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.224])
	by ozlabs.org (Postfix) with ESMTP id 519DBDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 15:12:09 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2710854rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:12:08 -0700 (PDT)
Date: Tue, 12 Aug 2008 23:12:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 5121 pci 2/3] powerpc: 5121: Add PCI support.
Message-ID: <20080813051205.GE17587@secretlab.ca>
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<1218130587-31176-2-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218130587-31176-2-git-send-email-jrigby@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 11:36:26AM -0600, John Rigby wrote:
> Uses mpc83xx_add_bridge in fsl_pci.c
> 
> Adds second register tuple to pci node register property
> as previously done for 83xx device trees in a previous patch.
> 
> Signed-off-by: John Rigby <jrigby@freescale.com>

Looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

I'll pick this one up once 1/3 is sorted out.

g.
