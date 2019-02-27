Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB0C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:39:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BEF213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 14:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BEF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448dcc2WqfzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 01:39:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.173; helo=1.mo69.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 2290 seconds by postgrey-1.36 at bilbo;
 Thu, 28 Feb 2019 01:37:39 AEDT
Received: from 1.mo69.mail-out.ovh.net (1.mo69.mail-out.ovh.net
 [178.33.251.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448dZC3ZyxzDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 01:37:36 +1100 (AEDT)
Received: from player168.ha.ovh.net (unknown [10.109.146.168])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 29D9C45796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 14:59:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 6D27030E2BBE;
 Wed, 27 Feb 2019 13:59:12 +0000 (UTC)
Date: Wed, 27 Feb 2019 14:59:11 +0100
From: Greg Kurz <groug@kaod.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
Message-ID: <20190227145911.60859bbb@bahia.lan>
In-Reply-To: <13209edc-d027-4d2f-668b-ad969a25eb06@linux.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
 <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
 <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
 <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
 <97ad5218-4876-956e-e6ef-fb3449eca68e@au1.ibm.com>
 <13209edc-d027-4d2f-668b-ad969a25eb06@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10932488099000326501
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrvddugdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: 'Alastair D'Silva' <alastair@au1.ibm.com>, 'Arnd
 Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 27 Feb 2019 14:45:44 +0100
Frederic Barrat <fbarrat@linux.ibm.com> wrote:

> Le 27/02/2019 =C3=A0 09:18, Andrew Donnellan a =C3=A9crit=C2=A0:
> > On 27/2/19 7:04 pm, Alastair D'Silva wrote: =20
> >>> -----Original Message-----
> >>> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> >>> Sent: Wednesday, 27 February 2019 6:55 PM
> >>> To: Alastair D'Silva <alastair@d-silva.org>; 'Alastair D'Silva'
> >>> <alastair@au1.ibm.com>
> >>> Cc: 'Greg Kurz' <groug@kaod.org>; 'Frederic Barrat'
> >>> <fbarrat@linux.ibm.com>; 'Arnd Bergmann' <arnd@arndb.de>; 'Greg Kroah-
> >>> Hartman' <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org;
> >>> linux-kernel@vger.kernel.org
> >>> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
> >>>
> >>> On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git
> >>> a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index =20
> >>>>>> e6a607488f8a..16eb8a60d5c7 100644
> >>>>>> --- a/drivers/misc/ocxl/file.c
> >>>>>> +++ b/drivers/misc/ocxl/file.c
> >>>>>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
> >>>>>> ocxl_context *ctx,
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (status =3D=3D ATTACHED) {
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int rc;
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct link *link =3D ctx->afu->fn->link;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 void *link =3D ctx->afu->fn->link; =20
> >>>>>
> >>>>> This doesn't look like a rename... =20
> >>>>
> >>>> That corrects the type to what the member (and prototype for =20
> >>> ocxl_link_update_pe) declare it as. =20
> >>>>
> >>>> The struct link there is bogus, it shouldn't even compile (since the=
=20
> >>>> intended =20
> >>> struct link is defined in a different compilation unit), but instead=
=20
> >>> picks up a
> >>> different definition of 'struct link' from elsewhere. =20
> >>>> =20
> >>>
> >>> Given there's only a handful of struct links defined across the=20
> >>> entire kernel,
> >>> I'm going to guess that the definition it's picking up is in fact the=
=20
> >>> ocxl one.
> >>> =20
> >>
> >> Unlikely, since that's never in a header. It wasn't caught since it=20
> >> was assigned to/from a void*. =20
> >=20
> > Ah, yeah that'd explain it... and it's a pointer so it never needs to=20
> > know its size. I'm clearly not very good at C.
> >  =20
> >> =20
> >>> I think the better solution here is to move struct ocxl_link into
> >>> ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather=
=20
> >>> than void
> >>> *, and update the function signature for ocxl_link_update_pe() as wel=
l. =20
> >> Not move it, but we could have an opaque declaration there.
> >> =20
> >=20
> > Putting it there would fit with all the other ocxl_* structs, but eithe=
r=20
> > way, we definitely need a declaration in there and get rid of the void*=
, t =20
>=20
>=20
> Mmm, it might turn out to be more invasive that planned...
> The point was only to have it as an opaque to the outside world, for=20
> APIs we'd like to deprecate at some point, so I wouldn't sweat too much=20
> over it.
>=20

I concur. And even if an API change turns out to be beneficial, it
clearly belongs to some other patch/series. Hence my proposal to
simply drop that controversial and unneeded link variable in
afu_ioctl_enable_p9_wait().

>    Fred
>=20

