Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A56F81A0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 11:28:03 +1100 (AEDT)
Message-ID: <1425947283.19022.8.camel@ellerman.id.au>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 10 Mar 2015 11:28:03 +1100
In-Reply-To: <1425700921.4636.213.camel@kernel.crashing.org>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
 <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
 <1425700921.4636.213.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-03-07 at 15:02 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2015-03-06 at 15:50 -0800, Olof Johansson wrote:
> > On Fri, Mar 6, 2015 at 2:56 PM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
> > >> On Fri, 06 Mar 2015 15:18:42 +1100
> > >> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > >>
> > >>
> > >> > Can you shoot me the DT (/proc/device-tree in a tarball) ?
> > >>
> > >> Attached.
> > >
> > > This is indeed a bug in their DT. We might want to add quirks for
> > > that unless it can be fixed (or has been via FW update). Olof ?
> > 
> > FW updates on this platform are highly unlikely. Quirk it is.
> 
> Oh I was not expecting a new FW, I was mostly wondering whether Steven
> had the latest one since I *think* Michael has been testing with the
> PA board we got here and didn't see that problem ... anyway, I'll check
> with him early next week and clean up / submit that patch.

Yeah I have been testing semi-regularly.

4.0-rc2 boots fine on mine.

But mine is an Athena, Steve's is an Electra. So they're not identical.

Mine is running:

  CFE version PAS-2.0.29 for ATHENA (64bit,MP,BE,PPC)
  Build Date: Mon Jun 30 11:47:25 PDT 2008 (mpl@mitch-1)

Steve is your CFE older than that?

Olof do you remember if that version or something newer is available for
Electra?

cheers
