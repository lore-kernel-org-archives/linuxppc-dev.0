Return-Path: <grimm@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 098751A0D19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 04:03:02 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <grimm@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 12:02:59 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4104F38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 12:02:56 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0JH2u6R30277826
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 17:02:56 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0JH2tdE021322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 12:02:55 -0500
Message-ID: <54BD38BC.5040305@linux.vnet.ibm.com>
Date: Mon, 19 Jan 2015 12:02:52 -0500
From: Ryan Grimm <grimm@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 1/4] CXL: Use image state defaults for reloading FPGA
References: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421643145-sup-9090@delenn.ozlabs.ibm.com>
In-Reply-To: <1421643145-sup-9090@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/19/2015 12:03 AM, Ian Munsie wrote:
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>
> Looks like you forgot your Signed-off-by line - mpe, do you want Ryan to
> resend the whole patch (maybe with the below explanation included), or
> just reply with a Signed-off-by?

OK resending.

-Ryan

>
> This would also be good to CC: Stable, as these new defaults mean that
> the card will be fully reset when sapphire PERSTs them on reboot,
> whereas before it was left up to the default value of this register in
> each card, and could lead to a card getting into a bad state requiring a
> full power cycle to recover. The symptoms we saw was the tlbia / slbia
> we do on boot timing out and the driver init aborting.
>
> Cheers,
> -Ian
>
