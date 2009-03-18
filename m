Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id 61796DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 02:50:53 +1100 (EST)
Received: by gxk1 with SMTP id 1so1665458gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 08:50:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090318154307.GB3182@loki.buserror.net>
References: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
	<D688018D-6CE0-4627-B813-FC552B1A6E83@kernel.crashing.org>
	<20090318152800.GA29557@oksana.dev.rtsoft.ru>
	<20090318154307.GB3182@loki.buserror.net>
Date: Wed, 18 Mar 2009 09:50:50 -0600
Message-ID: <fa686aa40903180850j6a2ee2ejded46d2233f1e591@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
From: Grant Likely <grant.likely@secretlab.ca>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 9:43 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Wed, Mar 18, 2009 at 06:28:00PM +0300, Anton Vorontsov wrote:
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0x24520 0x20>;
>>
>> Yes, will change.
>
> I'd prefer ranges =3D <0 0x24000 0x1000>, in case any other sub-blocks co=
me
> along in the future.

FWIW, ditto.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
