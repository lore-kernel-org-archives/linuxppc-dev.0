Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A5F82C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 08:32:55 +1000 (EST)
Received: by yhnn12 with SMTP id n12so5773875yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 15:32:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <CACxGe6uo8jx3GQFQpQ5RTHF5JyN2hEgvcvdmSYfGyTQnzK9fOA@mail.gmail.com>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop>
 <CACxGe6uFvtro7iR8FewgChLr_6PnZA-EaRMKQjrFEaEHg7SKRQ@mail.gmail.com>
 <1343082371.2957.39.camel@pasglop>
 <CACxGe6uo8jx3GQFQpQ5RTHF5JyN2hEgvcvdmSYfGyTQnzK9fOA@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Jul 2012 16:32:31 -0600
Message-ID: <CACxGe6udruWL7oo6Qp6jkwQYceduTO1h1gKFz9TFX1TPZoNFNQ@mail.gmail.com>
Subject: Re: next/mmotm unbootable on G5: irqdomain
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Mon, Jul 23, 2012 at 4:31 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jul 23, 2012 at 4:26 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Mon, 2012-07-23 at 01:59 -0600, Grant Likely wrote:
>>> My tree must be rebased to eliminate bisect breakage. The existing
>>> commits in my tree have the breakage, and fiddling with the merge
>>> order doesn't affect that. I don't want to rebase though. The safest
>>> approach (smallest window of breakage) is to apply that fix onto my
>>> irqdomain tree.
>>
>> With your other breakage on pseries I'm thinking rebasing might be the
>> only option...
>
> Fair enough. I'm not planning to ask Linus to pull for a few days yet
> anyway. I've been pretty useless as a kernel maintainer for the last 3
> months so I want to give a bit more time in linux-next to catch
> fallout before it gets merged.
>
> As-is I'm backing off from the linear/legacy/tree merge patch as just
> too risky. I've already pulled that stuff out of linux-next.

Can I pull you pseries fix into my tree (my preference), or do I need
to rebase on top of yours?

g.
