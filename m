Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 2CCDADDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 04:10:28 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so517384rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:10:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1240941326.3710.0@antares>
References: <fa686aa40904271036n5c610fdehe1c7906fff2b893b@mail.gmail.com>
	<1240941326.3710.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 28 Apr 2009 12:10:07 -0600
Message-ID: <fa686aa40904281110v58040801l9f08173e86342889@mail.gmail.com>
Subject: Re: How to use Localbus on 5200B w/ 2.6.29.1
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 11:55 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Hi Grant:
>
> Am 27.04.09 19:36 schrieb(en) Grant Likely:
>>
>> For completeness use: compatible =3D
>> "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus"; =A0Then it will work.
>
> I doesn't. =A0I had to add "fsl,lpb", without no localbus nodes show up. =
=A0The
> file arch/powerpc/platforms/52xx/mpc52xx_common.c lists only "fsl,lpb" =
=A0as
> "compatible". =A0Or did I miss something here?

Ah, I guess I didn't merge that fix until 2.6.30.  fsl,lpb works for
now.  What I wrote about is the recommended value for .30 and later,
just because it is clearer.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
