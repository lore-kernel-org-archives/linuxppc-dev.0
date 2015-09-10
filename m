Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBA71A0075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 04:14:49 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 10 Sep 2015 12:14:11 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 99BD51FF0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 12:05:16 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8AID00s39125008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 11:13:00 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8AIE6i6014113
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 12:14:07 -0600
Date: Thu, 10 Sep 2015 11:06:55 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/16] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150910180655.GA30048@us.ibm.com>
References: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150831190521.GC31119@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150831190521.GC31119@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| Arnaldo, Ingo,
| 
| I added Andi's patch https://lkml.org/lkml/2015/8/28/521 to 'json-v16' branch.
| and created a new branch, 'json-files-7' with updated to Intel data files.
| Here are the three new branches.
| 
|  	https://github.com:sukadev/linux.git 
|  	
|  	Branch			Description
|  	------------------------------------------------------
|  	json-v16		Source Code only 
|  	json-files-7		x86 and Powerpc datafiles only
|  	json-v16.1-with-data	Both code and data (for build/test)

Arnaldo, Ingo,

I have not received any comments on this patch set since it was Acked by
Jiri Olsa in June. Can you please queue this up for 4.3?

Thanks,

Sukadev
