Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id CC6D71A0E5B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 02:24:50 +1000 (AEST)
Date: Wed, 27 May 2015 09:24:47 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] perf: Add power8 PMU events in JSON format
Message-ID: <20150527162447.GN7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150527135928.GB29557@danjae.kornet>
 <20150527144101.GM7484@tassilo.jf.intel.com>
 <CAM9d7cjxrH6vxoJ1Cui62BRHNgxK=NSH-LyQxfULpz6oVvsn+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM9d7cjxrH6vxoJ1Cui62BRHNgxK=NSH-LyQxfULpz6oVvsn+w@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 28, 2015 at 12:01:31AM +0900, Namhyung Kim wrote:
> On Wed, May 27, 2015 at 11:41 PM, Andi Kleen <ak@linux.intel.com> wrote:
> >> > +  {
> >> > +    "EventCode": "0x2505e",
> >> > +    "EventName": "PM_BACK_BR_CMPL",
> >> > +    "BriefDescription": "Branch instruction completed with a target address less than current instruction address,",
> >> > +    "PublicDescription": "Branch instruction completed with a target address less than current instruction address.,"
> >>
> >> Can't we remove PublicDescription field if it's identical to
> >> BriefDescription?  It seems just wasting spaces..
> >
> > It's not always identical. There are events where PublicDescription is much longer (several paragraphs)
> 
> I know.  What I said is make it optional so that we can drop if it's identical.

Should be easy enough. It's already optional in the jevents parser.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
