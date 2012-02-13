Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH stable-2.6.27] powerpc: Add more Power7 specific
 definitions
In-reply-to: <20120213063528.GU21225@1wt.eu>
References: <8849.1329094322@neuling.org> <20120213063528.GU21225@1wt.eu>
Date: Mon, 13 Feb 2012 20:15:20 +1100
Message-ID: <2018.1329124520@neuling.org>
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org,
 Eric B Munson <emunson@mgebm.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Willy,

> > stable-2.6.27.60 added c24cb8e5 which uses PV_POWER7 but it's not
> > defined.  Following patch adds these definitions.
> 
> Thank you for the report Michael, I have no PPC toolchain so I have
> not tested this one. Added now.

No problem.

> Just one question, with this release, no -rc patch was emitted. Do you
> think you would have built it in time if I had provided a way to
> retrieve the -rc patch ? I'm asking because it's much more difficult
> right now to put it somewhere, but for instance it can be emitted with
> the announcement mail.

I would test it but to fit with my work flow I'd really like the rc in a
git tree.  I've asked gregkh to do this in the past, but he's not been
able to.  Hence I only test the final releases.

Thanks,
Mikey
