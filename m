Return-Path: <leoyang.li@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxs6q1wZJzDr2Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:38:09 +1000 (AEST)
From: Leo Li <leoyang.li@nxp.com>
To: Scott Wood <oss@buserror.net>, Karim Eshapa <karim.eshapa@gmail.com>
CC: Roy Pledge <roy.pledge@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck hacking
 jiffies.
Date: Tue, 27 Jun 2017 16:38:00 +0000
Message-ID: <AM4PR0401MB1699F4CD65C50361933D2FA48FDC0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
 <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
In-Reply-To: <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Scott Wood [mailto:oss@buserror.net]
> Sent: Saturday, June 24, 2017 9:47 PM
> To: Karim Eshapa <karim.eshapa@gmail.com>
> Cc: Roy Pledge <roy.pledge@nxp.com>; linux-kernel@vger.kernel.org;
> Claudiu Manoil <claudiu.manoil@nxp.com>; colin.king@canonical.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; Leo =
Li
> <leoyang.li@nxp.com>
> Subject: Re: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
> hacking jiffies.
>=20
> On Fri, May 05, 2017 at 07:45:18AM +0200, Karim Eshapa wrote:
> > Use msleep() instead of stucking with
> > long delay will be more efficient.
> >
> > Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> > ---
> >  drivers/soc/fsl/qbman/qman.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> Acked-by: Scott Wood <oss@buserror.net>
>=20
> (though the subject line should be "soc/qman: ...")
>=20
> Leo, are you going to send this patch (and other qman patches) via arm-so=
c?

Yes.  I can take it through the pull request for soc/fsl via arm-soc.  As m=
entioned in the feedback from David in another email, probably we should up=
date the comment and commit message to mention how 10000 cycles becomes 1ms=
.

Regards,
Leo
