Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D43A1A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:15:08 +1000 (AEST)
Date: Wed, 22 Jul 2015 15:15:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@au1.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling
 <michael.neuling@au1.ibm.com>, "sonal.santan" <sonal.santan@xilinx.com>,
 Jeremy Kerr <jk@ozlabs.org>, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes
 as "memory"
Message-ID: <20150722151502.15d557c4@kryten>
In-Reply-To: <1437525346-sup-7472@delenn.ozlabs.ibm.com>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten>
 <1437447984.30722.3.camel@ellerman.id.au>
 <20150722091844.114ea023@kryten>
 <1437525346-sup-7472@delenn.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

> > > > Nice catch! I wonder if we should be checking for device_type
> > > > "memory". Ben?
> > > 
> > > Yes. That's what Linux does.
> > 
> > Ian: I made that change, and slightly modified your commit message.
> > Look ok?
> 
> Looks good to me :)

Excellent, I just pushed the fix.

Anton
