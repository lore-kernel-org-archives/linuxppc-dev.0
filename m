Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DABC1A0144
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 04:56:12 +1000 (AEST)
Date: Mon, 21 Sep 2015 20:56:04 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: ak@linux.intel.com, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/16] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150921185604.GC29091@krava.redhat.com>
References: <1440569166-22169-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150831190521.GC31119@us.ibm.com>
 <20150910180655.GA30048@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150910180655.GA30048@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 10, 2015 at 11:06:55AM -0700, Sukadev Bhattiprolu wrote:
> Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
> | Arnaldo, Ingo,
> | 
> | I added Andi's patch https://lkml.org/lkml/2015/8/28/521 to 'json-v16' branch.
> | and created a new branch, 'json-files-7' with updated to Intel data files.
> | Here are the three new branches.
> | 
> |  	https://github.com:sukadev/linux.git 
> |  	
> |  	Branch			Description
> |  	------------------------------------------------------
> |  	json-v16		Source Code only 
> |  	json-files-7		x86 and Powerpc datafiles only
> |  	json-v16.1-with-data	Both code and data (for build/test)
> 
> Arnaldo, Ingo,
> 
> I have not received any comments on this patch set since it was Acked by
> Jiri Olsa in June. Can you please queue this up for 4.3?

hi,
any news about this one?

thanks,
jirka
