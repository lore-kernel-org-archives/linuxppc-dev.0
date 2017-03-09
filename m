Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf10k02gqzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 17:37:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] powerpc: kretprobes: override default function
 entry offset
In-Reply-To: <20170308164644.GK11046@naverao1-tp.localdomain>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <53bcae5a711eab803c9c3210110e8a464df34202.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9xcujzi.fsf@concordia.ellerman.id.au>
 <20170308142412.GI11046@naverao1-tp.localdomain>
 <20170308142916.GA3035@kernel.org>
 <20170308164644.GK11046@naverao1-tp.localdomain>
Date: Thu, 09 Mar 2017 17:37:38 +1100
Message-ID: <87a88vuf9p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> On 2017/03/08 11:29AM, Arnaldo Carvalho de Melo wrote:
>> > I wasn't sure if you were planning on picking up KPROBES_ON_FTRACE for 
>> > v4.11. If so, it would be good to take this patch through the powerpc 
>> > tree. Otherwise, this can go via Ingo's tree.
>> 
>> If you guys convince Ingo that this should go _now_, then just cherry
>> pick what was merged into tip/perf/core that is needed for the arch
>> specific stuff and go from there.
>
> Ok, in hindsight, I think Michael's concern was actually for v4.12 

Yes I was talking about 4.12, sorry I thought that was implied :)

> itself, in which case this particular patch can go via powerpc tree, 
> while the rest of the patches in this series can go via your tree.
>
> Michael?

Yeah I think that's the easiest option. The function will be temporarily
unused until the two trees are merged, but I think that's fine.

cheers
