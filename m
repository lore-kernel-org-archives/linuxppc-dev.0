Return-Path: <srs0=0fsy=ik=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rfSM2XlRzF0wj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:21:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40rfSL6Hx7z8tLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 03:21:22 +1000 (AEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40rfSK3C2hz9s16
 for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2018 03:21:21 +1000 (AEST)
Date: Wed, 23 May 2018 19:21:01 +0200
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH stable 4.16 00/14] powerpc backports for 4.16
Message-ID: <20180523172101.GA1215@kroah.com>
References: <20180522144125.10345-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522144125.10345-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 23, 2018 at 12:41:11AM +1000, Michael Ellerman wrote:
> Hi Greg,
> 
> Please queue up this series of patches for 4.16 if you have no objections.
> 
> These are mostly clean backports but one or two required some fixing up, hench
> the backport.

All now applied, thanks.

greg k-h
