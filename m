Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E5F91A0311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:35:05 +1100 (AEDT)
Message-ID: <1448418904.3762.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Append linux_banner to exception information
 in xmon.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 25 Nov 2015 13:35:04 +1100
In-Reply-To: <1448408261-30772-1-git-send-email-rashmicy@gmail.com>
References: <1448408261-30772-1-git-send-email-rashmicy@gmail.com>
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

Hi Rashmica,

Can you make your subject "powerpc/xmon: ...".

On Wed, 2015-11-25 at 10:37 +1100, Rashmica Gupta wrote:

> Currently if you are in xmon without an oops etc. to view the kernel version you have to type "d $linux_banner" - not necessarily obvious. As this is useful information, append to the output of "e"
> command.

This line should be word wrapped.

And can you include an example of the output in the change log?

cheers
