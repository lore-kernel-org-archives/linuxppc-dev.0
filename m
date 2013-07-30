Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E4AD02C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 10:29:47 +1000 (EST)
Message-ID: <1375144178.3721.13.camel@pasglop>
Subject: Re: [PATCH] Add device file bindings for MAPLE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 30 Jul 2013 10:29:38 +1000
In-Reply-To: <1375142451.30721.68@snotra>
References: <1374930222-32739-1-git-send-email-shaveta@freescale.com>
 <1375142451.30721.68@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Shaveta Leekha <shaveta@freescale.com>, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-07-29 at 19:00 -0500, Scott Wood wrote:
> On 07/27/2013 08:03:42 AM, Shaveta Leekha wrote:
> > Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> > ---
> >  .../devicetree/bindings/powerpc/fsl/maple.txt      |   50  
> > ++++++++++++++++++++

BTW, that's confusing, we have a platform called maple ... oh well...

Cheers,
Ben.
