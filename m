Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 7BC561A2ADA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 05:00:54 +1000 (AEST)
Date: Thu, 10 Sep 2015 16:00:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/16] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150910190048.GE23511@kernel.org>
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

Em Thu, Sep 10, 2015 at 11:06:55AM -0700, Sukadev Bhattiprolu escreveu:
> Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
> | I added Andi's patch https://lkml.org/lkml/2015/8/28/521 to 'json-v16' branch.
> | and created a new branch, 'json-files-7' with updated to Intel data files.
> | Here are the three new branches.

> |  	https://github.com:sukadev/linux.git 

> |  	Branch			Description
> |  	------------------------------------------------------
> |  	json-v16		Source Code only 
> |  	json-files-7		x86 and Powerpc datafiles only
> |  	json-v16.1-with-data	Both code and data (for build/test)
 
> Arnaldo, Ingo,
 
> I have not received any comments on this patch set since it was Acked by
> Jiri Olsa in June. Can you please queue this up for 4.3?

If you haven't noticed, I am waiting on Ingo on this one, IIRC he tried
looking at it recently, asked for a rebase, you did it, so it is in his
plate now,

Thanks,

- Arnaldo
