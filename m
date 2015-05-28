Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67CA11A1B57
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:43:25 +1000 (AEST)
Date: Thu, 28 May 2015 14:43:18 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/10] perf: Add support for PMU events in JSON format
Message-ID: <20150528124318.GL12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150528114206.GB12392@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528114206.GB12392@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 28, 2015 at 01:42:06PM +0200, Jiri Olsa wrote:

SNIP

> > 	git@github.com:sukadev/linux.git #branch json-v11
> 
> could you please also pull in Andi's changes with x86 events?
> it seems to be under his tree branch perf/builtin-json-2,
> follwing commits:
> 
> b68aa7b0d4e4 perf, tools: Add Broadwell V9 event file
> 1873bf40be27 perf, tools: Add HaswellX V12 event file
> dc9a37d4f96c perf, tools: Add Bonnell V1 event file
> f8cce1c4abb6 perf, tools: Add Silvermont V8 event file
> c92a43e0a6c9 perf, tools: Add Haswell V18 event file
> 67ac6d3d8e2f perf, tools: Add IvyBridge V14 event file
> 3777bd7a8bf2 perf, tools: Add IvyTown V16 event file
> 21f34ff8ddb3 perf, tools: Add Jaketown V17 event file
> 22b22b279559 perf, tools: Add SandyBridge V11 event file
> 542c99a4836d perf, tools: Add WestmereEP-DP V1 event file
> b2f0315e50b3 perf, tools: Add WestmereEP-SP V1 event file
> 82601ad46a58 perf, tools: Add WestmereEX V1 event file
> a52987f230e0 perf, tools: Add NehalemEP V1 event file
> a8fedce09cc1 perf, tools: Add NehalemEX V1 event file
> 
> no need to post them ATM.. just to have all stuff
> on one place will ease up testing
> 
> Andi, you'd be ok with that I guess ;-)

also could you please rebase this on latest Arnaldo's perf/core?

thanks,
jirka
