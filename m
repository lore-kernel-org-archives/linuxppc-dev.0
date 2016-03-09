Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CAB41A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 21:31:29 +1100 (AEDT)
Message-ID: <1457519488.8111.4.camel@ellerman.id.au>
Subject: Re: [v6,12/20] cxl: Add guest-specific code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 Mar 2016 21:31:28 +1100
In-Reply-To: <56DFE97D.6040606@linux.vnet.ibm.com>
References: <20160309055533.92479140BB4@ozlabs.org>
 <56DFE97D.6040606@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-09 at 10:14 +0100, Frederic Barrat wrote:

> Hi Michael,
>
> Le 09/03/2016 06:55, Michael Ellerman a écrit :

> > This breaks the SMP=n build:
>
> Arg! I'm adding it to my checklist.

Don't worry about it too much. It's pretty obscure, and I have an automated
test for it.

We've broken the SMP=n build in the past for *months* at a time and no one's
noticed.

> Thanks for the fix.

No worries.

cheers
