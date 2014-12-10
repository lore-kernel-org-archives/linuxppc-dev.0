Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F09A11A075D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 15:08:20 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Tue, 9 Dec 2014 21:08:18 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 67F7F19D8039
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 20:56:55 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBA47Gif20971602
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 21:07:16 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBA48Fk3023341
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 21:08:15 -0700
Date: Wed, 10 Dec 2014 09:41:45 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC PATCH 8/8] perf probe powerpc: Fixup function entry if
 using kallsyms lookup
Message-ID: <20141210041144.GA13398@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <e5bfde8d51546041e50699c4ed3bad8c3c1bf84f.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <20141209211400.GB8788@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141209211400.GB8788@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 09, 2014 at 06:14:00PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 09, 2014 at 11:04:06PM +0530, Naveen N. Rao escreveu:
> > On powerpc ABIv2, if no debug-info is found and we use kallsyms,
> > we need to fixup the function entry to point to the local entry point.
> > Use offset of 8 since current toolchains always generate 2
> > instructions (8 bytes).
> 
> Hi Michael and Ananth, may I have your Acked-by or Reviewed-by for these
> patches?
> 
> The ones, like this, that are affects only ppc I'm can assume was tested
> and applying it won't break other arch users, but having a/rev-by from
> ppc developers should speed up this process.

Hi Arnaldo,

Yes, I have reviewed the patches. So, for all patches...

Reviewed-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
