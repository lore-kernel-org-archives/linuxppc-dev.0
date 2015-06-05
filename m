Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 086701A08C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 20:29:16 +1000 (AEST)
Date: Fri, 5 Jun 2015 12:29:07 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V14 00/14] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20150605102907.GA17556@krava.redhat.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2015 at 11:27:08PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> 	- All known events tables for the architecture are included in the
> 	  perf binary.
> 
> 	- For architectures that don't have any JSON files, an empty mapping
> 	  table is created and they should continue to build)
> 
> Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.
> 
> These patches are available from:
> 
> 	https://github.com:sukadev/linux.git 
> 	
> 		Branch			Description
> 		------------------------------------------------------
> 		json-v14		Source Code only 
> 		json-files-3		x86 and Powerpc datafiles only
> 		json-v14-with-data	Both code and data (build/test)
> 	
> NOTE: 	Only "source code" patches (i.e those in json-v14) are being emailed.
> 	Please pull the "data files" from the json-files-3 branch.
> 
> Changelog[v14]
> 	Comments from Jiri Olsa:
> 	- Change parameter name/type for pmu_add_cpu_aliases (from void *data
> 	  to list_head *head)
> 	- Use asprintf() in file_name_to_tablename() and simplify/reorg code.
> 	- Use __weak definition from <linux/compile.h>
> 	- Use fopen() with mode "w" and eliminate unlink()
> 	- Remove minor TODO.
> 	- Add error check for return value from strdup() in print_pmu_events().
> 	- Move independent changes from patches 3,11,12 .. to separate patches
> 	  for easier review/backport.
> 	- Clarify mapfile's "header line support" in patch description.
> 	- Fix build failure with DEBUG=1

all my comments were addressed and apart from 2 small comments,
for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
