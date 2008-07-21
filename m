Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1E8ABDDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:49:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [HOW] binutils-2.17 breaks the 2.6.26 kernel
Date: Mon, 21 Jul 2008 11:49:56 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B7A9B3@ismail.innsys.innovsys.com>
In-Reply-To: <3400bffa9d49e09b00e04cafcd751322@kernel.crashing.org>
References: <1dce2aab6509053e60f7a59a30974749@bga.com><9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
	<3400bffa9d49e09b00e04cafcd751322@kernel.crashing.org>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Jon Smirl" <jonsmirl@gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Segher Boessenkool
> > Previous threads have mentioned that binutil-2.17 is broken for
> > building powerpc kernels. It is fixed in binutils-2.18.
>=20
> I have a working (tested! thanks Milton) workaround for the current
> problem, will send it later today.  This problem funnily is hidden
> by the presence of build-id :-)

Did you ever send this patch? I'd like to try it as I cannot compile a
arch/powerpc 2.6.265 kernel right now.
