Return-Path: <srs1=dmfv=kernel.org==e1is=iu=linuxfoundation.org=gregkh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yhtN4dgyzF0tD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:31:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40yhtN13Kpz8svM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 23:31:24 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40yhtM1kvZz9s0x
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2018 23:31:22 +1000 (AEST)
Date: Sat, 2 Jun 2018 15:30:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH stable 4.9 00/23] powerpc backports for 4.9
Message-ID: <20180602133058.GA22989@kroah.com>
References: <20180602110908.29773-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180602110908.29773-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 02, 2018 at 09:08:45PM +1000, Michael Ellerman wrote:
> Hi Greg,
> 
> Please queue up this series of patches for 4.9 if you have no objections.
> 
> The first one is not a backport but a fix for a previous backport.

Looks good, all now queued up, thanks.

greg k-h
