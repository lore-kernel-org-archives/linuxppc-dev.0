Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 5FB67DDF2B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:08:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi devices should use mode "cpu" or "qe"
Date: Wed, 3 Oct 2007 17:56:37 +0200
Message-ID: <1191426997.6422.34.camel@gentoo-jocke.transmode.se>
References: <87przwxkzf.fsf@macbook.be.48ers.dk>
	<085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-03 at 10:51 -0500, Kumar Gala wrote:
> On Oct 3, 2007, at 10:43 AM, Peter Korsgaard wrote:
>=20
> > According to booting-without-of.txt, fsl_spi mode should be either
> > "cpu" or "qe", not "cpu-qe".
> >
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>=20
> I think we should update the doc instead of the code here. Thoughts?

Yes, "cpu-qe" means QE in CPU mode. There is a native QE mode too that
isn't impl. in the driver yet. "qe" should be reserved for native QE
mode.

 Jocke=20
