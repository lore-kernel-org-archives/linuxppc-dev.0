Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 706F12C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Nov 2013 08:04:15 +1100 (EST)
Message-ID: <1385240643.4882.133.camel@pasglop>
Subject: Re: [PATCH v2] offb: make the screen properties endian safe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Sun, 24 Nov 2013 08:04:03 +1100
In-Reply-To: <5290E820.2080809@fr.ibm.com>
References: <1383185307.5117.74.camel@pasglop>
 <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
 <1384987801.26969.114.camel@pasglop> <528E2A89.90601@fr.ibm.com>
 <1385063848.4882.6.camel@pasglop> <5290E820.2080809@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-11-23 at 18:38 +0100, Cedric Le Goater wrote:
> So, 32bpp "works" but 16 is broken ... I guess my palette fix is just a lucky
> hack and I need to dig deeper in fb code to have a better understanding of
> the color map. 
> 
> I should have provided you two patches in the first place. Do you want the 
> device tree data fixes for the frame buffer screen properties ? It helps to 
> have a display for little endian guests even if the colors are wrong.

Before you pull your hair out, check if it works in BE :-)

Cheers,
Ben.
