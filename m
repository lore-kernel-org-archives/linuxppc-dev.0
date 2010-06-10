Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100610171029.GA18824@oksana.dev.rtsoft.ru>
References: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
	<AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
	<AANLkTimjIyclTWZZW1A26zOcWroK-bwOkmEqsLm4DINk@mail.gmail.com>
	<20100610171029.GA18824@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 11:21:16 -0600
Message-ID: <AANLkTinG8oDNsTEjFrV36Sv4okTL1RBuaFCpOvH_PJt1@mail.gmail.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
To: Anton Vorontsov <cbouatmailru@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org, "M. Warner Losh" <imp@bsdimp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 11:10 AM, Anton Vorontsov
<cbouatmailru@gmail.com> wrote:
> On Thu, Jun 10, 2010 at 10:30:26AM -0600, Grant Likely wrote:
> [...]
>> =A0 =A0 =A0 res =3D kzalloc((sizeof(*res) * num_res), GFP_KERNEL);
>> =A0 =A0 =A0 if (!res) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(ofdev); =A0/* or goto an error unwind =
label */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 res =3D (struct resource *)&ofdev[1];
>
> You mean ofdev->resource =3D res; ?

Yeah, cut-and-paste error.

g.
