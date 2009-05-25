Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id BD269DDFEB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 00:39:30 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1688978qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 07:39:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905242334o4867d701n9de332721eb2f3b4@mail.gmail.com>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013851.3073.79847.stgit@terra>
	<fa686aa40905242334o4867d701n9de332721eb2f3b4@mail.gmail.com>
Date: Mon, 25 May 2009 10:39:27 -0400
Message-ID: <9e4733910905250739h2fa9f438le25d9acf555b3d55@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] Support for AC97 on Phytec pmc030 base board.
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 2:34 AM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> This is ugly. =A0I'd really rather have a generic mechanism for creating
> a fabric driver based on the OF data. =A0But failing that, it seems to
> me that this platform device registration should be done in the
> platform code (arch/powerpc/platforms/52xx). =A0Doing it in a module
> init looks wrong.

I'm all for deleting it as soon as AC97 is capable of auto-loading.  I
thought it was better to leave it in the sound directories to keep it
isolated since the intention is to remove it when possible.

BTW, my binding files are quite simple compared to mpc8610_hpcd.c.


>
> I was trying to do a sort of generic matching mechanism with the of
> simple stuff; but admittedly it was hacky and half-assed. =A0However, I
> do still think it is viable to have OF hooks that kick in when codec
> and machine drivers are registered. =A0If linkage data is encoded in the
> device tree, then generic code should be able to hook them up; pulling
> additional data out of the device tree as needed to configure the
> coded.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Jon Smirl
jonsmirl@gmail.com
