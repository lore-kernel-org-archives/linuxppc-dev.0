Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN9HX3xjDzDrRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 10:03:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Clarke <pc@us.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf/python: Add ppc64le to audit uname list
In-Reply-To: <28cdd58e-326d-ff93-e820-2ae47104ee0b@us.ibm.com>
References: <20170802144216.12494-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170802150605.GH12201@kernel.org>
 <28cdd58e-326d-ff93-e820-2ae47104ee0b@us.ibm.com>
Date: Thu, 03 Aug 2017 10:03:03 +1000
Message-ID: <87o9rxr008.fsf@concordia.ellerman.id.au>
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

Paul Clarke <pc@us.ibm.com> writes:

> Coincidentally, I just saw a developer stumble upon this within the last
> week.  Could this be pushed upstream soon?

acme's tree is upstream for perf.

I assume you mean into Linus' tree? If so this should land in 4.14.

cheers
