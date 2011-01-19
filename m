Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH 1/2] powerpc: document the MPIC device tree binding
Date: Wed, 19 Jan 2011 22:14:42 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150306BF11@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
In-Reply-To: <AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> +** Optional properties:
> +
> + =A0 - no-reset : The presence of this property indicates that the MPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should not be reset during runtime initi=
alization.
> + =A0 - protected-sources : Specifies a list of interrupt sources that ar=
e
> + not
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 available for use and w=
hose corresponding
> + vectors
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 should not be initializ=
ed. =A0A typical use case
> + for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 this property is in AMP=
 systems where multiple
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 independent operating s=
ystems need to share
> + the MPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 without clobbering each=
 other.

Is "protected-sources" really needed for AMP systems to
tell the OSes not to clobber each other?  Won't each
OS be given a device tree with only its interrupt
sources?  ...so you know what you are allowed to touch.

Stuart
