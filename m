Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfZdQ0Sw5zDq6Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 02:51:54 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 02:51:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DC6D92CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 02:51:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u35GpSvv10617292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 02:51:36 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u35Gp4kh014365
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 02:51:04 +1000
Date: Tue, 5 Apr 2016 22:20:07 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@fb.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "David S. Miller" <davem@davemloft.net>,
 Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net 2/4] lib/test_bpf: Add tests for unsigned BPF_JGT
Message-ID: <20160405165007.GB15993@naverao1-tp.in.ibm.com>
References: <5e3cf7c4a971e6d2ff7a2d50bbec2e6e26883b84.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <6b946d54d20d96052ce4f4baec308cdb20ace39a.1459850410.git.naveen.n.rao@linux.vnet.ibm.com>
 <5703E5C5.5060901@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5703E5C5.5060901@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/05 09:20AM, Alexei Starovoitov wrote:
> On 4/5/16 3:02 AM, Naveen N. Rao wrote:
> >Unsigned Jump-if-Greater-Than.
> >
> >Cc: Alexei Starovoitov <ast@fb.com>
> >Cc: Daniel Borkmann <daniel@iogearbox.net>
> >Cc: "David S. Miller" <davem@davemloft.net>
> >Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> >Cc: Michael Ellerman <mpe@ellerman.id.au>
> >Cc: Paul Mackerras <paulus@samba.org>
> >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> I think some of the tests already cover it, but extra tests are
> always great.
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> 
> I think the whole set belongs in net-next.
> Next time you submit the patches please say [PATCH net-next] in subject.
> [PATCH net] is for bugfixes only.

Ah, sure. Thanks for the review!

- Naveen
