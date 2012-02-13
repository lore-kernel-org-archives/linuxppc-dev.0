Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id E8AA4B6FAB
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2012 17:35:49 +1100 (EST)
Date: Mon, 13 Feb 2012 07:35:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH stable-2.6.27] powerpc: Add more Power7 specific
 definitions
Message-ID: <20120213063528.GU21225@1wt.eu>
References: <8849.1329094322@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8849.1329094322@neuling.org>
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

On Mon, Feb 13, 2012 at 11:52:02AM +1100, Michael Neuling wrote:
> stable-2.6.27.60 added c24cb8e5 which uses PV_POWER7 but it's not
> defined.  Following patch adds these definitions.

Thank you for the report Michael, I have no PPC toolchain so I have
not tested this one. Added now.

Just one question, with this release, no -rc patch was emitted. Do you
think you would have built it in time if I had provided a way to retrieve
the -rc patch ? I'm asking because it's much more difficult right now to
put it somewhere, but for instance it can be emitted with the announcement
mail.

Regards,
Willy
