Return-Path: <lig.fnst@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 586592C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:20:44 +1000 (EST)
Subject: Re: [PATCH] powerpc/pseries: use 'true' instead of '1' for
 orderly_poweroff
From: li guang <lig.fnst@cn.fujitsu.com>
To: Joe Perches <joe@perches.com>
In-Reply-To: <1369898064.22004.134.camel@joe-AO722>
References: <1369897651-23770-1-git-send-email-lig.fnst@cn.fujitsu.com>
 <1369898064.22004.134.camel@joe-AO722>
Date: Thu, 30 May 2013 15:20:06 +0800
Message-ID: <1369898406.15177.38.camel@liguang.fnst.cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E5=9C=A8 2013-05-30=E5=9B=9B=E7=9A=84 00:14 -0700=EF=BC=8CJoe Perches=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, 2013-05-30 at 15:07 +0800, liguang wrote:
> > orderly_poweroff is expecting a bool parameter, so
> > use 'ture' instead '1'
> []
> > diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platfo=
rms/pseries/ras.c
> []
> > @@ -162,7 +162,7 @@ void rtas_parse_epow_errlog(struct rtas_error_log *=
log)
> > =20
> >  	case EPOW_SYSTEM_HALT:
> >  		pr_emerg("Firmware initiated power off");
> > -		orderly_poweroff(1);
> > +		orderly_poweroff(ture);
> >  		break;
>=20
> Compile your patches _before_ submitting them please.
>=20
> "true" not "ture" here and in the commit message.
>=20

right, thanks!
