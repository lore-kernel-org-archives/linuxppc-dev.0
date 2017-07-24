Return-Path: <qiang.zhao@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10074.outbound.protection.outlook.com [40.107.1.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGGYT6NJ8zDqxZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:39:41 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Leo Li <leoyang.li@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] fsl/qe: NULL dereference on error in
 ucc_of_parse_tdm()
Date: Mon, 24 Jul 2017 09:39:32 +0000
Message-ID: <AM3PR04MB1185598E49501B538AD88A4091BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <20170722073335.tb6byaaarqvloh3a@mwanda>
 <AM3PR04MB1185AD2A435269F988D3BF2291BB0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <20170724070424.3rlrzh2jjqkcjxpf@mwanda>
In-Reply-To: <20170724070424.3rlrzh2jjqkcjxpf@mwanda>
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

On Mon 7/24/2017 3:04 PM, Dan Carpenter <dan.carpenter@oracle.com>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, July 24, 2017 3:04 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; linuxppc-dev@lists.ozlabs.org; kernel-
> janitors@vger.kernel.org
> Subject: Re: [PATCH 1/2] fsl/qe: NULL dereference on error in
> ucc_of_parse_tdm()
>=20
> On Mon, Jul 24, 2017 at 02:24:14AM +0000, Qiang Zhao wrote:
> > On Sat 7/22/2017 3:34 PM, Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> >
> > > -----Original Message-----
> > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > Sent: Saturday, July 22, 2017 3:34 PM
> > > To: Qiang Zhao <qiang.zhao@nxp.com>
> > > Cc: Leo Li <leoyang.li@nxp.com>; linuxppc-dev@lists.ozlabs.org;
> > > kernel- janitors@vger.kernel.org
> > > Subject: [PATCH 1/2] fsl/qe: NULL dereference on error in
> > > ucc_of_parse_tdm()
> > >
> > > If "pdev =3D of_find_device_by_node(np2);" fails then it would lead t=
o
> > > a NULL dereference.  This function is called from probe() and we're
> > > using managed resources so we can just return without doing a manual
> cleanup.
> >
> > You mean it will be cleaned up automatically?
>=20
> Yes.  At module unload.

Do you mean when insmod it as a module, and when this module is removed, it=
 will be cleaned up automatically?
Do I understand correctly?
Well, how about build-in?

Best Regards
Qiang Zhao
