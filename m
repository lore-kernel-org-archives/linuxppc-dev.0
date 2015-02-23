Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0021.hostedemail.com
 [216.40.44.21])
 by lists.ozlabs.org (Postfix) with ESMTP id C67F91A0C85
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 01:59:51 +1100 (AEDT)
Message-ID: <1424703585.20944.28.camel@perches.com>
Subject: Re: [PATCH v2] cxl: Add explicit precision specifiers
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Mon, 23 Feb 2015 06:59:45 -0800
In-Reply-To: <1424688935-6645-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1424662685-sup-6648@delenn.ozlabs.ibm.com>
 <1424688935-6645-1-git-send-email-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-23 at 11:55 +0100, Rasmus Villemoes wrote:
> 24 of the %.16llx
> matches are in drivers/misc/cxl/, so internal consistency wins.

I think that's more an argument for changing all of the
cx1 uses to "%016llx".
