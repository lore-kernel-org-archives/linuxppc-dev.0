Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 967B61A061B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 13:44:32 +1000 (AEST)
Message-ID: <1435808670.10635.0.camel@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 bharata@linux.vnet.ibm.com
Date: Thu, 02 Jul 2015 13:44:30 +1000
In-Reply-To: <20150702083103.61151467@kryten>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <87lhfs5ewc.fsf@linux.vnet.ibm.com> <20150623111648.1e31a497@kryten>
 <87d20mewk2.fsf@linux.vnet.ibm.com> <20150702083103.61151467@kryten>
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

On Thu, 2015-07-02 at 08:31 +1000, Anton Blanchard wrote:
> Hi Nikunj,
> 
> > > Thanks for the patch. Have we tested that this doesn't regress the
> > > non dynamic representation?
> > 
> > Yes, that is tested. And works as expected.
> 
> Great, you can add:
> 
> Acked-by: Anton Blanchard <anton@samba.org>

Hi Nikunj,

Please resend a non-RFC version, with the updated changelog and Anton's ack
included.

cheers
