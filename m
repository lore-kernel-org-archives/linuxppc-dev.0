Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id 56AA5B7D64
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 02:03:11 +1000 (EST)
Received: by ywh41 with SMTP id 41so4326295ywh.9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 09:03:09 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1274032079.1729.3@antares>
References: <20100505220916.GD3529@ovro.caltech.edu>
	<1273168472.1767.1@antares>
	<h2mfa686aa41005061106ofda766f5z64c4f631eaded414@mail.gmail.com>
	<1274032079.1729.3@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 10:02:48 -0600
Message-ID: <AANLkTikrF7-oxN5BzdiJga0XbMbQPKKj-SqwLp46_GQb@mail.gmail.com>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 16, 2010 at 11:47 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Am 06.05.10 20:06 schrieb(en) Grant Likely:
>>
>> > I think, though, the whole stuff has been discussed in depth in
>> > February, so
>> > I do not understand why it's still pending as "new". =A0Grant, did we =
miss
>> > something here?
>>
>> I generally let subsystem maintainers pick up the device driver
>> patches for embedded platforms I'm responsible for unless I'm asked to
>> do otherwise. =A0I think ben has asked me to take these through my tree.
>
> That's <http://git.secretlab.ca/?p=3Dlinux-2.6.git;a=3Dshortlog>, isn't i=
t?
> =A0Hmmm, didn't find it there... :-/

Ugh... Stupid typing too fast.  I meant to say, "I *don't* think ben
has asked me to take..."

Well this leaves a bit of a mess.  I'll make sure it gets in one way or ano=
ther.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
