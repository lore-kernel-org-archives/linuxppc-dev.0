Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdNbX1s8szDqgq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:17:44 +1000 (AEST)
Date: Thu, 24 Aug 2017 14:17:39 +0200
From: msuchanek <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Jonathan Corbet <corbet@lwn.net>, Jessica Yu
 <jeyu@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Jason Baron
 <jbaron@akamai.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Mahesh J
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Scott Wood <oss@buserror.net>, Oliver O'Halloran
 <oohall@gmail.com>, David Howells <dhowells@redhat.com>, Sylvain 'ythier'
 Hitier <sylvain.hitier@gmail.com>, Ingo Molnar <mingo@kernel.org>, Kees
 Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, "Steven
 Rostedt\," <rostedt@goodmis.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Tejun Heo <tj@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Baoquan He
 <bhe@redhat.com>, Ilya Matveychikov <matvejchikov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] boot/param: add pointer to next argument to
 unknown parameter callback
Message-ID: <20170824141739.190826e4@naga>
In-Reply-To: <87shghusz0.fsf@concordia.ellerman.id.au>
References: <78655b3689f6cd0c76b787b8ef2c824ef75a99a5.1503000577.git.msuchanek@suse.de>
 <6378df7aed5bb23863d7762d7dc2babdd5e32a45.1503000577.git.msuchanek@suse.de>
 <87shghusz0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Aug 2017 21:04:51 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Suchanek <msuchanek@suse.de> writes:
> 
> > The fadump parameter processing re-does the logic of next_arg quote
> > stripping to determine where the argument ends. Pass pointer to the
> > next argument instead to make this more robust.
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  arch/powerpc/kernel/fadump.c  | 13 +++++--------
> >  arch/powerpc/mm/hugetlbpage.c |  4 ++--
> >  include/linux/moduleparam.h   |  2 +-
> >  init/main.c                   | 12 ++++++------
> >  kernel/module.c               |  4 ++--
> >  kernel/params.c               | 19 +++++++++++--------
> >  lib/dynamic_debug.c           |  2 +-
> >  7 files changed, 28 insertions(+), 28 deletions(-)  
> 
> Can you split out a patch that adds the next argument and updates the
> callers. And then a patch for the fadump to use the new arg.
> 
> cheers

Yes, that makes sense.

Thanks

Michal
