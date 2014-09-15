Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34DA11A0AD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 13:01:32 +1000 (EST)
Message-ID: <1410750091.24738.8.camel@concordia>
Subject: Re: [PATCH v2 1/2] pseries: Fix endian issues in onlining cpu threads
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 13:01:31 +1000
In-Reply-To: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-12 at 14:11 -0500, Thomas Falcon wrote:
> The ibm,ppc-interrupt-server#s property is in big endian format.
> These values need to be converted when used by little endian
> architectures.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
> Changes in v2:
> 
>  Followed suggestions from Michael Ellerman
>    conversion of intserv values occur once

Thanks Tom.

I think I saw that you'd already discussed these with Nathan in another thread,
so I'll assume he's OK with them unless he says otherwise.

cheers
