Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F4A01A093B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 16:45:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 12:15:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BC2ABE0067
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:19:04 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N6j1m834013308
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 12:15:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N5QWpS008888
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 10:56:32 +0530
Message-ID: <55B08D6B.8000304@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 12:14:59 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 0/7]powerpc/powernv: Nest Instrumentation support
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20150720184312.GA11548@us.ibm.com>
In-Reply-To: <20150720184312.GA11548@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 21 July 2015 12:13 AM, Sukadev Bhattiprolu wrote:
> Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> | This patchset enables Nest Instrumentation support on powerpc.
> | POWER8 has per-chip Nest Intrumentation which provides various
> | per-chip metrics like memory, powerbus, Xlink and Alink
> | bandwidth.
> | 
> <snip>
>
> | Cc: Michael Ellerman <mpe@ellerman.id.au>
> | Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> | Cc: Paul Mackerras <paulus@samba.org>
> | Cc: Anton Blanchard <anton@samba.org>
> | Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> | Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> | Cc: Stephane Eranian <eranian@google.com>
> | Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>
> Thanks for addressing my comments from earlier version.
>
> Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Thanks for the review
Maddy
