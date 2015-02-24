Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EA0E1A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 11:12:39 +1100 (AEDT)
Message-ID: <1424736758.2318.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] cxl: Add explicit precision specifiers
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>
Date: Tue, 24 Feb 2015 11:12:38 +1100
In-Reply-To: <1424703585.20944.28.camel@perches.com>
References: <1424662685-sup-6648@delenn.ozlabs.ibm.com>
 <1424688935-6645-1-git-send-email-linux@rasmusvillemoes.dk>
 <1424703585.20944.28.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Ian Munsie <imunsie@au1.ibm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-23 at 06:59 -0800, Joe Perches wrote:
> On Mon, 2015-02-23 at 11:55 +0100, Rasmus Villemoes wrote:
> > 24 of the %.16llx
> > matches are in drivers/misc/cxl/, so internal consistency wins.
> 
> I think that's more an argument for changing all of the
> cx1 uses to "%016llx".

+1

cheers
