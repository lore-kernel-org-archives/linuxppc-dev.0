Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 75797DDFCF
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:30:21 +1000 (EST)
Received: by gxk20 with SMTP id 20so774152gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:30:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506220119.7322783420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
	<20090506220119.7322783420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:29:59 -0600
Message-ID: <fa686aa40905061529u11b231afle3b5bb10a2334ad0@mail.gmail.com>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:01 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
> in message <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com> =
you wrote:
>>
> ...
>> > #ifdef CONFIG_FS_ENET_HAS_FEC
>> > +#ifdef CONFIG_FS_ENET_MPC5121_FEC
>> > + =A0 =A0{
>> > + =A0 =A0 =A0 =A0.compatible =3D "fsl,mpc5121-fec",
>> > + =A0 =A0 =A0 =A0.data =3D (void *)&fs_fec_ops,
>> > + =A0 =A0},
>> > +#else
>> > =A0 =A0{
>> > =A0 =A0 =A0 =A0.compatible =3D "fsl,pq1-fec-enet",
>> > =A0 =A0 =A0 =A0.data =3D (void *)&fs_fec_ops,
>> > =A0 =A0},
>> > #endif
>> > +#endif
>>
>> Hmmm. =A0A lot of these #ifdefs in here. =A0Does this have a multiplatfo=
rm
>> impact? =A0Not to mention the fact that it's just plain ugly. =A0:-)
>
> Agreed that it's ugly, but duplicatio9ng the code would have been even
> worse. I don't think that it has multiplatform - at least not as long
> as you don't ask for one image that runs on 83xx and on 512x.

Actually, I *am* asking for one image that runs on 83xx, 52xx and
521x.  I already can and do build and test a single image which boots
on all my 52xx boards, on my 8349 board, and on my G4 Mac.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
