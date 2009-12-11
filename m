Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B25FB7C72
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 13:13:45 +1100 (EST)
Subject: Re: [PATCH 3/3] mpc8xxx_gpio: add interrupt support
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <87pr6omwk3.fsf@macbook.be.48ers.dk>
Date: Thu, 10 Dec 2009 20:13:35 -0600
Message-Id: <8F2E2097-9BB7-4B7F-902E-F967F28120E8@kernel.crashing.org>
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-2-git-send-email-jacmet@sunsite.dk>
	<1259700494-17869-3-git-send-email-jacmet@sunsite.dk>
	<87pr6omwk3.fsf@macbook.be.48ers.dk>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 9, 2009, at 1:33 AM, Peter Korsgaard wrote:

>>>>>> "Peter" =3D=3D Peter Korsgaard <jacmet@sunsite.dk> writes:
>=20
> Comments?
>=20
> Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Peter> ---
> Peter>  arch/powerpc/sysdev/mpc8xxx_gpio.c |  147 =
++++++++++++++++++++++++++++++++++++
> Peter>  1 files changed, 147 insertions(+), 0 deletions(-)

We need a binding document to go with this.

- k=
