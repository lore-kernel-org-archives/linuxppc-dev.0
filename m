Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFF961A113B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 06:24:48 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 27 May 2015 14:24:45 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2394F1FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:15:53 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t4RKMVb326673176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 13:22:31 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4RKOg9i017526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 14:24:42 -0600
Date: Wed, 27 May 2015 13:24:11 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] perf: Add power8 PMU events in JSON format
Message-ID: <20150527202411.GA12747@us.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135928.GB29557@danjae.kornet>
 <20150527144101.GM7484@tassilo.jf.intel.com>
 <CAM9d7cjxrH6vxoJ1Cui62BRHNgxK=NSH-LyQxfULpz6oVvsn+w@mail.gmail.com>
 <20150527162447.GN7484@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150527162447.GN7484@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andi Kleen [ak@linux.intel.com] wrote:
| > I know.  What I said is make it optional so that we can drop if it's identical.
| 
| Should be easy enough. It's already optional in the jevents parser.

I have removed the duplicated entries in power8.json.
