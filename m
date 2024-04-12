Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D379C4345F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2024 06:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VG67Z20NVz3vsK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2024 16:27:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VG677265zz3vln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2024 16:27:27 +1000 (AEST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvAMf-000k1Z-Ta; Fri, 12 Apr 2024 14:26:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 14:26:39 +0800
Date: Fri, 12 Apr 2024 14:26:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new trust
 source
Message-ID: <ZhjUH3TZ99cT3Rhq@gondor.apana.org.au>
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
 <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: David Gstir <david@sigma-star.at>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, James Morris <jmorris@namei.org>, NXP Linux Team <linux-imx@nxp.com>, James Bottomley <jejb@linux.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, sigma star Kernel Team <upstream+dcp@sigma-star.at>, "Steven Rostedt \(Google\)" <rostedt@goodmis.org>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>, linux-s
 ecurity-module@vger.kernel.org, linux-crypto@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Tejun Heo <tj@kernel.org>, linux-integrity@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 03, 2024 at 06:47:51PM +0300, Jarkko Sakkinen wrote:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I can only test that this does not break a machine without the
> hardware feature.

Please feel free to take this through your tree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
