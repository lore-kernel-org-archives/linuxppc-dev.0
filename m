Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBvKC02rzzDrJv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 08:02:22 +1000 (AEST)
Date: Tue, 18 Jul 2017 14:52:04 -0700 (PDT)
Message-Id: <20170718.145204.114892351718806712.davem@davemloft.net>
To: robh@kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jslaby@suse.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] tty: Convert to using %pOF instead of full_name
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170718214339.7774-54-robh@kernel.org>
References: <20170718214339.7774-54-robh@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Jul 2017 16:43:34 -0500

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For sparc bits:

Acked-by: David S. Miller <davem@davemloft.net>
