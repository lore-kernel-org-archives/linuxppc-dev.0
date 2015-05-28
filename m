Return-Path: <ak@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 98DC11A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 04:07:08 +1000 (AEST)
Date: Thu, 28 May 2015 11:07:05 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] perf, tools: Add a --no-desc flag to perf list
Message-ID: <20150528180705.GQ7484@tassilo.jf.intel.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150528123914.GJ12392@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150528123914.GJ12392@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 28, 2015 at 02:39:14PM +0200, Jiri Olsa wrote:
> On Wed, May 27, 2015 at 02:23:28PM -0700, Sukadev Bhattiprolu wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Add a --no-desc flag to perf list to not print the event descriptions
> > that were earlier added for JSON events. This may be useful to
> > get a less crowded listing.
> > 
> > It's still default to print descriptions as that is the more useful
> > default for most users.
> 
> I might not be typical user, but the first thing I tried to
> explore was 'perf list -v' ;-)
> 
> would it be better to have just the list with event names for:
>    $ perf list
> 
> and with descriptions for:
>    $ perf list -v
> 
> not sure we already discussed this..

It was discussed last time. I think it's better to have descriptions
by default. Far more user friendly.

One thing we could in theory do with -v is to switch between Brief and Public
Description (the later is often more verbose). Would need some changes
to the alias code to have two descriptions though.

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only
