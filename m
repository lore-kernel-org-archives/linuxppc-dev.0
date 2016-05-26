Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFW5x2kTkzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 11:00:21 +1000 (AEST)
Message-ID: <1464224420.31009.0.camel@ellerman.id.au>
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 bhelgaas@google.com
Date: Thu, 26 May 2016 11:00:20 +1000
In-Reply-To: <201605251303.u4PCx7bK033656@mx0a-001b2d01.pphosted.com>
References: <3qWdQC0MVDz9s9Y@ozlabs.org> <56F9255A.1040900@linux.vnet.ibm.com>
 <1464155117.8573.2.camel@ellerman.id.au>
 <201605251303.u4PCx7bK033656@mx0a-001b2d01.pphosted.com>
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

On Wed, 2016-05-25 at 10:03 -0300, Guilherme G. Piccoli wrote:
> On 05/25/2016 02:45 AM, Michael Ellerman wrote:
> > 
> > Yeah please increase the bitmap size to 65536. It will only take 8KB of memory,
> > which is negligible.
> 
> Well, since I sent a v6 and you replied there too, I guess we can 
> continue our iterations there - mostly suggestions (all except one) you 
> gave here were implemented in v6.

Yeah sorry, I'm very behind on email :)

cheers
