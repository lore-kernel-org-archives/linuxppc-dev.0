Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4283Tq1bD9zF323
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 20:01:19 +1000 (AEST)
Message-ID: <5db170d7504095793c1b258a05d99df678ce3a21.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Haren Myneni
 <haren@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 10 Sep 2018 20:01:18 +1000
In-Reply-To: <20180910101001.71a31102@naga.suse.cz>
References: <20180910054405.32422-1-mikey@neuling.org>
 <20180910101001.71a31102@naga.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > For stable I've marked this as v4.13+ since that's when we refactored
> > code-patching.c but it could go back even further than that. In
> > reality though, I think we can only hit this since the first
> > spectre/meltdown changes.
>=20
> Which means it affects all maintained stable trees because the
> spectre/meltdown changes are backported.

Yep we this this on SLES12 SP3=20

Mikey
