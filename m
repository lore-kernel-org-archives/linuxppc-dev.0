Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C13CBB6F87
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 07:21:24 +1100 (EST)
Message-ID: <1322684475.29041.2.camel@pasglop>
Subject: Re: [PATCH 4/6] powerpc/boot: Add extended precision shifts to the
 boot wrapper.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 01 Dec 2011 07:21:15 +1100
In-Reply-To: <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-5-git-send-email-tony@bakeyournoodle.com>
 <1322632107.21641.43.camel@pasglop>
 <CA+5PVA6kBquh2=sPy25PKGSMBWvoZFFvZjrL4bgdmddFgjyaQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-30 at 06:45 -0500, Josh Boyer wrote:
> On Wed, Nov 30, 2011 at 12:48 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2011-11-30 at 16:23 +1100, Tony Breeds wrote:
> >> Code copied from arch/powerpc/kernel/misc_32.S
> >>
> >> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> >> ---
> >>  arch/powerpc/boot/div64.S |   52 +++++++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 52 insertions(+), 0 deletions(-)
> >
> > Should we just link with libgcc ? :-)
> 
> Please tell me you're joking.

Only half... I wonder what it would look like. Wouldn't ld only pickup
what we use anyway ?

> However, adding this code and wonderful and all but why do we need to
> add it?  Changelog should say why.

Agreed.

Cheers,
Ben.
