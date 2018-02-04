Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yK1fLVzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yJ4xcPz8t8G
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:16 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yJ0xMNz9t3C
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:15 +1100 (AEDT)
Date: Sun, 4 Feb 2018 12:07:57 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 00/16] powerpc stable backports for v4.4
Message-ID: <20180204110757.GL7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 03:59:54PM +1100, Michael Ellerman wrote:
> Hi Greg,
> 
> This is a backport to v4.4 of the RFI flush series that went upstream recently.
> There's also a few other commits I noticed had not made it to v4.4 due to
> needing manual backports.

I've queued these up, and filled in for the 4.9.y and 4.14.y trees where
needed.  I think I'm only missing one 4.9.y backport, and have responded
to that specific patch.

thanks,

greg k-h
