Return-Path: <B40534@freescale.com>
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: RE: [PATCH v2 1/2] powerpc/mpic: Add Open-PIC global timer document
Date: Mon, 13 Aug 2012 04:10:06 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DB1407@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344578002-8057-1-git-send-email-Dongsheng.wang@freescale.com>
 <94D8FBCC-7AA8-4F50-90A3-2A11F579AC34@freescale.com>
In-Reply-To: <94D8FBCC-7AA8-4F50-90A3-2A11F579AC34@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org Discuss"
 <devicetree-discuss@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>=20
> > a/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> > b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> > index df41958..5aafca0 100644
> > --- a/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-timer.txt
> > @@ -1,13 +1,14 @@
> > * Freescale MPIC timers
> >
> > Required properties:
> > -- compatible: "fsl,mpic-global-timer"
> > +- compatible: "fsl,global-timer"
>=20
> Why are renaming?.. also use of fsl,global-timer is to generic of a name
> for the this.
>=20
[Wang Dongsheng] "fsl,global-timer" is generic of a name.
