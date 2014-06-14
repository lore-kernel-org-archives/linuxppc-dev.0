Return-Path: <marex@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0983E1A0459
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jun 2014 13:48:24 +1000 (EST)
From: Marek Vasut <marex@denx.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] crypto/nx: disable NX on little endian builds
Date: Sat, 14 Jun 2014 05:48:14 +0200
References: <20140607113334.474343b8@kryten>
In-Reply-To: <20140607113334.474343b8@kryten>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201406140548.14201.marex@denx.de>
Cc: herbert@gondor.apana.org.au, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, linux-crypto@vger.kernel.org, nfont@linux.vnet.ibm.com,
 mhcerri@linux.vnet.ibm.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday, June 07, 2014 at 03:33:34 AM, Anton Blanchard wrote:
> The NX driver has endian issues so disable it for now.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

What kind of issues ? Are they hard to fix ?

Best regards,
Marek Vasut
