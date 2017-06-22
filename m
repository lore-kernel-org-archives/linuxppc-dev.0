Return-Path: <robherring2@gmail.com>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtlYM4TZ0zDr0w
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 01:16:55 +1000 (AEST)
Received: by mail-io0-f196.google.com with SMTP id m19so4326312ioe.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 08:16:55 -0700 (PDT)
Date: Thu, 22 Jun 2017 10:16:51 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Dan Douglass <dan.douglass@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] of: update ePAPR references to point to Devicetree
 Specification
Message-ID: <20170622151651.ghls5dgrrcjl7tnj@rob-hp-laptop>
References: <1497408544-7383-1-git-send-email-frowand.list@gmail.com>
 <20170618140531.jvmnttawom4ns55b@rob-hp-laptop>
 <5947A62D.6050504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5947A62D.6050504@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2017 at 03:23:41AM -0700, Frank Rowand wrote:
> On 06/18/17 07:05, Rob Herring wrote:
> > On Tue, Jun 13, 2017 at 07:49:04PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> The Devicetree Specification has superseded the ePAPR as the
> >> base specification for bindings.  Update files in Documentation
> >> to reference the new document.
> >>
> >> Some files are not updated because there is no hypervisor chapter
> >> in the Devicetree Specification:
> >>    Documentation/devicetree/bindings/powerpc/fsl/msi-pic.txt
> >>    Documenation/virtual/kvm/api.txt
> >>    Documenation/virtual/kvm/ppc-pv.txt

> >> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> >> index f8cd2397aa04..d63ab1dec16d 100644
> >> --- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> >> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> >> @@ -3,10 +3,10 @@ Power Architecture CPU Binding
> >>  Copyright 2013 Freescale Semiconductor Inc.
> >>  
> >>  Power Architecture CPUs in Freescale SOCs are represented in device trees as
> >> -per the definition in ePAPR.
> >> +per the definition in the Devicetree Specification.
> > 
> > Are we sure we didn't remove any PPC specifics that apply here?
> 
> I don't see any.
> 
> Table 3.7.1 "General Properties of CPU nodes" was slightly
> re-ordered, but the same properties are listed in both documents.
> 
> I don't think that the boot requirements removal impacts this
> file.
> 
> Am I missing something?

No, I just wanted to make sure. So I guess there's just that one minor 
thing to drop.

Rob
