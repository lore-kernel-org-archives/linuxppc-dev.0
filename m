Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B4D72C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 08:26:45 +1000 (EST)
Message-ID: <1343082371.2957.39.camel@pasglop>
Subject: Re: next/mmotm unbootable on G5: irqdomain
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Jul 2012 08:26:11 +1000
In-Reply-To: <CACxGe6uFvtro7iR8FewgChLr_6PnZA-EaRMKQjrFEaEHg7SKRQ@mail.gmail.com>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop>
 <CACxGe6uFvtro7iR8FewgChLr_6PnZA-EaRMKQjrFEaEHg7SKRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 Paul Mundt <lethal@linux-sh.org>, Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 01:59 -0600, Grant Likely wrote:
> My tree must be rebased to eliminate bisect breakage. The existing
> commits in my tree have the breakage, and fiddling with the merge
> order doesn't affect that. I don't want to rebase though. The safest
> approach (smallest window of breakage) is to apply that fix onto my
> irqdomain tree.

With your other breakage on pseries I'm thinking rebasing might be the
only option...

Cheers,
Ben.
