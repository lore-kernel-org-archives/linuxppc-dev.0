Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skqnw74BvzDrLP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 06:59:31 +1000 (AEST)
Date: Thu, 29 Sep 2016 06:59:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Paulo
 Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>, George Wilson
 <gcwilson@us.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [PATCH 0/3] Fix crypto/vmx/p8_ghash memory corruption
Message-ID: <20160929065908.653ec5c2@kryten>
In-Reply-To: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
References: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Marcelo

> This series fixes the memory corruption found by Jan Stancek in
> 4.8-rc7. The problem however also affects previous versions of the
> driver.

If it affects previous versions, please add the lines in the sign off to
get it into the stable kernels.

Anton
