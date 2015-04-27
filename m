Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C87B1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 13:30:27 +1000 (AEST)
Message-ID: <1430105426.8494.6.camel@ellerman.id.au>
Subject: Re: [PATCH V2 2/8] ipmi/powernv: Convert to irq event interface
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Date: Mon, 27 Apr 2015 13:30:26 +1000
In-Reply-To: <1428654294-9177-2-git-send-email-alistair@popple.id.au>
References: <1428654294-9177-1-git-send-email-alistair@popple.id.au>
 <1428654294-9177-2-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 18:24 +1000, Alistair Popple wrote:
> Convert the opal ipmi driver to use the new irq interface for events.

>  drivers/char/ipmi/ipmi_powernv.c | 39 ++++++++++++++++++++++-----------------

This needs to be CC'ed to the IPMI folks, and preferably get their ACK so we
can take the whole series via the powerpc tree.

cheers
