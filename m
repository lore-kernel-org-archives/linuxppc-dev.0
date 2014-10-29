Return-Path: <brking@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A8081A1A64
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 04:35:12 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 29 Oct 2014 11:35:10 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 97BB519D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 11:23:49 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9THWp3g9240854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 18:32:51 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9THZ5Nc004053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 11:35:06 -0600
Message-ID: <54512546.8010006@linux.vnet.ibm.com>
Date: Wed, 29 Oct 2014 12:35:02 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, wenxiong@linux.vnet.ibm.com,
 scottwood@freescale.com
Subject: Re: [PATCH 2/2] ipr: set coherent DMA mask
References: <1413191676-1663-1-git-send-email-anton@samba.org>
 <1413191676-1663-2-git-send-email-anton@samba.org>
In-Reply-To: <1413191676-1663-2-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Brian King <brking@linux.vnet.ibm.com>


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
