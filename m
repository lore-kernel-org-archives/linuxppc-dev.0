Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 839B41A0198
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 15:02:22 +1100 (AEDT)
Message-ID: <1425700921.4636.213.camel@kernel.crashing.org>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Date: Sat, 07 Mar 2015 15:02:01 +1100
In-Reply-To: <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
References: <20150305171239.3a8135e6@gandalf.local.home>
 <1425615522.4636.173.camel@kernel.crashing.org>
 <20150306100021.5637d790@gandalf.local.home>
 <1425682582.4636.197.camel@kernel.crashing.org>
 <CAOesGMjBjmVQtdA85Uc2QrVT6enVShOx-iyXdZLvH9vuq8t=wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-06 at 15:50 -0800, Olof Johansson wrote:
> On Fri, Mar 6, 2015 at 2:56 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Fri, 2015-03-06 at 10:00 -0500, Steven Rostedt wrote:
> >> On Fri, 06 Mar 2015 15:18:42 +1100
> >> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >>
> >>
> >> > Can you shoot me the DT (/proc/device-tree in a tarball) ?
> >>
> >> Attached.
> >
> > This is indeed a bug in their DT. We might want to add quirks for
> > that unless it can be fixed (or has been via FW update). Olof ?
> 
> FW updates on this platform are highly unlikely. Quirk it is.

Oh I was not expecting a new FW, I was mostly wondering whether Steven
had the latest one since I *think* Michael has been testing with the
PA board we got here and didn't see that problem ... anyway, I'll check
with him early next week and clean up / submit that patch.

Cheers,
Ben.

> 
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
