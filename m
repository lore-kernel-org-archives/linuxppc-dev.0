Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7178B67A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 09:00:12 +1100 (EST)
Date: Wed, 15 Feb 2006 14:00:09 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "dibacco@inwind.it" <dibacco@inwind.it>
Subject: Re: MMU is enabled in u-boot?
Message-ID: <20060215220009.GA15168@gate.ebshome.net>
References: <IUR10W$F435AD432BF7E29E360C74B2CBBCC42B@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IUR10W$F435AD432BF7E29E360C74B2CBBCC42B@libero.it>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2006 at 10:58:08PM +0100, dibacco@inwind.it wrote:
> u-boot works with MMU enabled? Why is it needed, if so?

Depends on CPU. Some CPUs just don't work without MMU.

-- 
Eugene
