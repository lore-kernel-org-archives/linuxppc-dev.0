Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 562DF2C007B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jun 2013 07:49:51 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 17:49:48 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DD77DC90068
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 17:49:31 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5ALnWlF224732
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 17:49:32 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5ALnVK8027547
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Jun 2013 15:49:31 -0600
Date: Mon, 10 Jun 2013 14:48:48 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf/Power7: Save dcache_src fields in sample record.
Message-ID: <20130610214848.GA2666@us.ibm.com>
References: <20130607204008.GA3281@us.ibm.com>
 <51B58843.5020809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51B58843.5020809@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual [khandual@linux.vnet.ibm.com] wrote:
| > The former approach seems less confusing and this patch uses that approach.
| > 
| 
| Yeah, the former approach is simpler and makes sense.

Ok. Seems to make sense at least on Power.

<snip>

| > + * We use the table, dcache_src_map, to map this value 1 to PERF_MEM_LVL_L3,
| > + * the arch-neutral representation of the L3 cache.
| > + *
| > + * Similarly, in case of marked data TLB miss, bits 14..17 of the MMCRA
| > + * indicate the load source of a marked DTLB  entry. dtlb_src_map[] gives
| > + * the mapping to the arch-neutral values of the TLB source.
| 
| 
| Where did you define dtlb_src_map[] ?

Ah, the comment belongs in another patch that I am working on. That patch
maps the PERF_MEM_TLB* flags to Power7.

Thanks for the comments.

Sukadev
