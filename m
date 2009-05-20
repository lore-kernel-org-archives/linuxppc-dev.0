Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id A23ABDE1E0
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:26:05 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so274847yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 09:26:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090520161511.GH29102@pengutronix.de>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
	<20090520155346.GG29102@pengutronix.de>
	<9e4733910905200910r5342c087pa4ebc579b37c8671@mail.gmail.com>
	<20090520161511.GH29102@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 10:25:44 -0600
Message-ID: <fa686aa40905200925o763179c7r27c12f7659560807@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
To: Wolfram Sang <w.sang@pengutronix.de>
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

On Wed, May 20, 2009 at 10:15 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
> On Wed, May 20, 2009 at 12:10:59PM -0400, Jon Smirl wrote:
>> On Wed, May 20, 2009 at 11:53 AM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: EEPROM */
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compa=
tible =3D "at24,24c32";
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <0x52>;
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> >>
>> >> Grant suggested this earlier...
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "atmel,24c32", "eeprom";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x52>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> >
>> > Can you give me a pointer? I just found this thread
>>
>>
>> Grant, what do you want here?
>
> I fear an answer like: "a properly working at24" ;)
>

BWAHAHAHAHA!

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
