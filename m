Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA2E31A11C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 22:39:21 +1000 (AEST)
Date: Thu, 28 May 2015 14:39:14 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] perf, tools: Add a --no-desc flag to perf list
Message-ID: <20150528123914.GJ12392@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-10-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432761809-4344-10-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 27, 2015 at 02:23:28PM -0700, Sukadev Bhattiprolu wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a --no-desc flag to perf list to not print the event descriptions
> that were earlier added for JSON events. This may be useful to
> get a less crowded listing.
> 
> It's still default to print descriptions as that is the more useful
> default for most users.

I might not be typical user, but the first thing I tried to
explore was 'perf list -v' ;-)

would it be better to have just the list with event names for:
   $ perf list

and with descriptions for:
   $ perf list -v

not sure we already discussed this..

jirka
