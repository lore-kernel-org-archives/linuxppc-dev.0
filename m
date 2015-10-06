Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EDA51A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 23:01:09 +1100 (AEDT)
Message-ID: <1444132868.16578.11.camel@ellerman.id.au>
Subject: Re: Who uses CROSS32_COMPILE ?
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org
Date: Tue, 06 Oct 2015 23:01:08 +1100
In-Reply-To: <CAOJe8K3ADovQA2-e7jND+eK_-LtLqHtbuKWp4tRi8xAdfuyL1A@mail.gmail.com>
References: <1444112101.16578.0.camel@ellerman.id.au>
 <CAOJe8K3ADovQA2-e7jND+eK_-LtLqHtbuKWp4tRi8xAdfuyL1A@mail.gmail.com>
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

On Tue, 2015-10-06 at 12:40 +0300, Denis Kirjanov wrote:
> On 10/6/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Does anyone build their kernels using CROSS32_COMPILE ?
> 
> I didn't even know that such macro exists..

Good, I want to remove it :)

cheers
