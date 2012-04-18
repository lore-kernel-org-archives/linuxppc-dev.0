Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EF067B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 08:18:03 +1000 (EST)
Message-ID: <1334787477.3143.18.camel@pasglop>
Subject: Re: [PATCH 1/4] powerpc: Require gcc 4.0 on 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 19 Apr 2012 08:17:57 +1000
In-Reply-To: <85510A09-D78C-432E-AAED-A0FB49D5325A@kernel.crashing.org>
References: <20120418144254.3286ce94@kryten>
 <85510A09-D78C-432E-AAED-A0FB49D5325A@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 09:28 -0500, Kumar Gala wrote:
> On Apr 17, 2012, at 11:42 PM, Anton Blanchard wrote:
> 
> > 
> > Older versions of gcc had issues with using -maltivec together with
> > -mcpu of a non altivec capable CPU. We work around it by specifying
> > -mcpu=970, but the logic is complicated.
> > 
> > In preparation for adding more -mcpu targets, remove the workaround
> > and just require gcc 4.0 for 64-bit builds.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> > ---
> > 
> > 4.0 came out in 2005 and the gcc on RHEL5 and SLES10 looks to be 4.1.
> > I highly doubt a ppc64 kernel will build these days on either RHEL4 or
> > SLES9.
> > 
> > Anything else we have to worry about?
> 
> There are probably embedded customers that might utilize older compilers, so this concerns me a little.

For 64-bit ? I doubt it ...

Cheers,
Ben.
