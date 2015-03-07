Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF8821A0198
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 19:27:31 +1100 (AEDT)
Message-ID: <1425716841.4636.219.camel@kernel.crashing.org>
Subject: Re: [REGRESSION in 3.18][PPC] PA Semi fails to boot after: of/base:
 Fix PowerPC address parsing hack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Perez <aperez@alexperez.com>
Date: Sat, 07 Mar 2015 19:27:21 +1100
In-Reply-To: <49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com>
References: <mailman.412.1425683254.7605.linuxppc-dev@lists.ozlabs.org>
 <49C58FDD-0206-4357-8CD2-46F3F7E4E739@alexperez.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-06 at 16:16 -0800, Alex Perez wrote:

> I will of course ultimately defer to Olof, but PASemi hasn’t existed
> for years, and there is no entity which could possibly update the DT
> for these reference PASemi development boards, unless Olof has source,
> which I’m pretty sure he does not :)

As I mentioned earlier, that's not what I had in mind :-) I was simply
wondering whether an existing newer FW with a fix already existed but
in any case, I'll submit the quirk next week, it doesn't hurt and is
pretty simple and localized.

Cheers,
Ben.
