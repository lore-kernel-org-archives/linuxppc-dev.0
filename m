Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE8C21A094B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 04:44:30 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jul 2015 14:44:26 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 38B3CC90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 14:35:31 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6KIiOBh59179076
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:44:24 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6KIiOlM019983
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 14:44:24 -0400
Date: Mon, 20 Jul 2015 11:43:13 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 0/7]powerpc/powernv: Nest Instrumentation support
Message-ID: <20150720184312.GA11548@us.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
| This patchset enables Nest Instrumentation support on powerpc.
| POWER8 has per-chip Nest Intrumentation which provides various
| per-chip metrics like memory, powerbus, Xlink and Alink
| bandwidth.
| 
<snip>

| Cc: Michael Ellerman <mpe@ellerman.id.au>
| Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
| Cc: Paul Mackerras <paulus@samba.org>
| Cc: Anton Blanchard <anton@samba.org>
| Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
| Cc: Stephane Eranian <eranian@google.com>
| Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Thanks for addressing my comments from earlier version.

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
