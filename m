Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxRMS3MlxzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 10:17:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5R0DkVk121189
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 20:17:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bb5h7fw4r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 20:17:37 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 26 Jun 2017 20:17:37 -0400
Date: Mon, 26 Jun 2017 17:17:27 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v3 02/23] powerpc: introduce set_hidx_slot helper
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
 <1498095579-6790-3-git-send-email-linuxram@us.ibm.com>
 <1498431798.7935.5.camel@gmail.com>
 <1498449778.31581.118.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498449778.31581.118.camel@kernel.crashing.org>
Message-Id: <20170627001727.GB5846@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 25, 2017 at 11:02:58PM -0500, Benjamin Herrenschmidt wrote:
> On Mon, 2017-06-26 at 09:03 +1000, Balbir Singh wrote:
> > On Wed, 2017-06-21 at 18:39 -0700, Ram Pai wrote:
> > > Introduce set_hidx_slot() which sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX)
> > > bits at  the  appropriate  location  in  the  PTE  of  4K  PTE.  In the
> > > case of 64K PTE, it sets the bits in the second part of the PTE. Though
> > > the implementation for the former just needs the slot parameter, it does
> > > take some additional parameters to keep the prototype consistent.
> > > 
> > > This function will come in handy as we  work  towards  re-arranging the
> > > bits in the later patches.
> 
> The name somewhat sucks. Something like pte_set_hash_slot() or
> something like that would be much more meaningful.

ok. pte_set_hash_slot() sounds good.
RP
