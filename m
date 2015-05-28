Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF9B71A1800
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 21:43:15 +1000 (AEST)
Date: Thu, 28 May 2015 13:43:08 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/10] perf: Add support for PMU events in JSON format
Message-ID: <20150528114308.GC12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 02:23:19PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> 	- All known events tables for the architecture are included in the
> 	  perf binary.
> 
> 	- Inconsistencies between the JSON files and the mapfile can result
> 	  in build failures in perf (although jevents try to recover from
> 	  some and continue the build by leaving out event aliases).
> 
> 	- For architectures that don't have any JSON files, an empty mapping
> 	  table is created and they should continue to build)
> 
> Thanks to input from Andi Kleen, Jiri Olsa, Namhyung Kim and Ingo Molnar.
> 
> These patches are available from
> 
> 	git@github.com:sukadev/linux.git #branch json-v11

found it publicly accessable/clone-able under:
  https://github.com/sukadev/linux.git

jirka
