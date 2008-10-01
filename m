Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 963A1DDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 21:23:15 +1000 (EST)
Date: Wed, 1 Oct 2008 13:22:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
Message-ID: <20081001132248.191e92b3@hyperion.delvare>
In-Reply-To: <20080930124424.GA6878@oksana.dev.rtsoft.ru>
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
	<20080930124424.GA6878@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

On Tue, 30 Sep 2008 16:44:24 +0400, Anton Vorontsov wrote:
> On Tue, Sep 23, 2008 at 06:12:19PM +0400, Anton Vorontsov wrote:
> > of/base.c matches on the first (most specific) entries, which isn't
> > quite practical but it was discussed[1] that this won't change.
> > 
> > The bindings specifies verbose information for the devices, but
> > it doesn't fit in the I2C ID's 20 characters limit. The limit won't
> > change[2], and the bindings won't change either as they're correct.
> > 
> > So we have to put an exception for the MPC8349E-mITX-compatible
> > MCUs.
> > 
> > [1] http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg21196.html
> > [2] http://www.nabble.com/-PATCH-1-2--i2c:-expand-I2C's-id.name-to-23-characters-td19577063.html
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/of/base.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Any issues with this or the second patch? Can we merge them?

I do not have the time to review these patches (and, honestly, have no
interest in them.) So I will not merge them but I have no objection to
them being merged by somebody else.

-- 
Jean Delvare
