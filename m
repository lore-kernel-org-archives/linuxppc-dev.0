Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzJLZ3k9yzDr4s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 11:08:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tejun Heo <tj@kernel.org>, Eryu Guan <eguan@redhat.com>
Cc: Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
In-Reply-To: <20170629142425.GB3531@htj.duckdns.org>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <20170629142425.GB3531@htj.duckdns.org>
Date: Fri, 30 Jun 2017 11:08:22 +1000
Message-ID: <87k23uqo3d.fsf@concordia.ellerman.id.au>
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

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> Could be the same problem as the one reported in the following thread.
>
>  http://lkml.kernel.org/r/1497266622.15415.39.camel@abdul.in.ibm.com
>
> The root cause there is ppc arch code not setting up possible cpu <->
> numa mapping during boot.

Huh?

You changed the workqueue code to avoid that in 2186d9f940b6
("workqueue: move wq_numa_init() to workqueue_init()"), didn't you?

cheers
