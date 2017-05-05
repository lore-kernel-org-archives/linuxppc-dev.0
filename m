Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKKjv3C30zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 04:12:19 +1000 (AEST)
Message-ID: <1494007913.25766.411.camel@kernel.crashing.org>
Subject: Re: [PATCH] crypto: vmx: Remove dubiously licensed crypto code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Paulo Flabiano
 Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, appro@openssl.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org
Date: Fri, 05 May 2017 20:11:53 +0200
In-Reply-To: <20170505155241.2274f347@kitsune.suse.cz>
References: <20170329125639.14288-1-msuchanek@suse.de>
 <20170329145135.GA28057@kroah.com>
 <20170329171327.38d4fdd6@kitsune.suse.cz>
 <7ec54553-610c-a5dc-d4d9-3c83f6a161d9@linux.vnet.ibm.com>
 <8591ac8ff6ef6fa9c4bd264017ac360d@linux.vnet.ibm.com>
 <20170505155241.2274f347@kitsune.suse.cz>
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

On Fri, 2017-05-05 at 15:52 +0200, Michal Suchánek wrote:
> 
> So you have an e-mail message from one of the authors of the code.
> Andy Polyakov wrote most of the code but there are probably other
> contributors who never gave explicit consent for using their code
> outside of OpenSSL.

The only contributions to that file in OpenSSL that isn't from Andy
are a whitespace fix and the addition of the licence :-)

If that makes you feel better we could undo the whitespace fix :-)

I've checked the other PowerPC related files in there and the situation
is identical (aes-ppc.pl does have also a spelling fix in comments).

At this point, it's pretty clear that this code is authored solely by
Andy who gave permission to use it.

Cheers,
Ben.
