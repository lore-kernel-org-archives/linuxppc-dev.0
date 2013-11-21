Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 162D72C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 06:57:41 +1100 (EST)
Message-ID: <1385063848.4882.6.camel@pasglop>
Subject: Re: [PATCH v2] offb: make the screen properties endian safe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Fri, 22 Nov 2013 06:57:28 +1100
In-Reply-To: <528E2A89.90601@fr.ibm.com>
References: <1383185307.5117.74.camel@pasglop>
 <1383212192-3622-1-git-send-email-clg@fr.ibm.com>
 <1384987801.26969.114.camel@pasglop> <528E2A89.90601@fr.ibm.com>
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

On Thu, 2013-11-21 at 16:45 +0100, Cedric Le Goater wrote:
> >  - fbdev *generally* assume native endian framebuffer, but of course
> > under qemu today, the adapter will use a big endian frame buffer
> > aperture. You can compile in support for foreign endian but I don't know
> > how that actually works.
> 
> OK. I will see how I can extend the tests. But, are you suggesting I should
> be using the foreign endian framework for the frame buffer ? 

Well, if it works ... did you try 16 and 32bpp ?

Cheers,
Ben.
