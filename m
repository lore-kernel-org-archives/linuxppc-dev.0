Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75C08B70E3
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Nov 2010 08:22:35 +1100 (EST)
Subject: RE: [PATCH v3] ppc44x:PHY fixup for USB on canyonlands board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rupjyoti Sarmah <rsarmah@apm.com>
In-Reply-To: <ade8814261339ab5028557ae3dc15c0b@mail.gmail.com>
References: <201011261110.oAQBANZL012455@amcc.com>
	<20101126142342.E05A411D94F1@gemini.denx.de>
	<ade8814261339ab5028557ae3dc15c0b@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 27 Nov 2010 08:22:19 +1100
Message-ID: <1290806539.32570.136.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-11-26 at 21:02 +0530, Rupjyoti Sarmah wrote:
> Hi Wolfgang,
> 
> >> This results in a mix of "amcc," and "apm," strings.
> >> Are there any plans to unify this?
> We can make all as apm, but right now I believe there is no plan to do so.
> 
> >>Earlier versions of the patch included a delay after the clrbits8()
> >>call as well. Is it intentional that you dropped this now?
> It is dropped intentionally.
> 
> Rest of your suggestions, I will modify and resubmit. Thanks.

I think this should remain consistent within the platform and stick to
"amcc".

Cheers,
Ben.
