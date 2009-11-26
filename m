Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 31C041007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:39:09 +1100 (EST)
Received: by ywh17 with SMTP id 17so405928ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 20:39:08 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259209283.16367.241.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<1259209283.16367.241.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 25 Nov 2009 21:38:48 -0700
Message-ID: <fa686aa40911252038y37da8c72y54314a6cc337fc66@mail.gmail.com>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 9:21 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2009-11-22 at 16:02 -0700, Grant Likely wrote:
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 video@0c002000 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "nintendo=
,flipper-video";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0c002000 0x10=
0>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <8>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&p=
ic>;
>>
>> Hint: =A0If you move the interrupt-parent property up to the root node,
>> then you don't need to specify it in every single device node; it will
>> just inherit from the parent.
>
> Note that this is a linux-ism no ? (aka ePAPRism). If they aim toward
> having a real OF which I think they do they may wish to pass on this
> trick.

But this isn't real OF.  Real OF can generate its own valid tree.
This is a flat tree, and it is valid according to all users of the
flat tree.  Besides, the last time we talked about this, you told me
that moving it to the root was a good idea, and I happily changed all
the 5200 .dts files.  :-)

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-January/067046.html

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
