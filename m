Return-Path: <riel@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 92E892C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 00:21:02 +1100 (EST)
Message-ID: <52FA23AE.3020207@redhat.com>
Date: Tue, 11 Feb 2014 08:20:46 -0500
From: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mgorman@suse.de,
 mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] mm: dirty accountable change only apply to non prot
 numa case
References: <1392114895-14997-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1392114895-14997-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1392114895-14997-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2014 05:34 AM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> So move it within the if loop
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
