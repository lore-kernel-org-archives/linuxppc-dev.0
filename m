Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 380A2B7B68
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 00:13:51 +1000 (EST)
Received: by ywh11 with SMTP id 11so77211ywh.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 07:13:50 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AB241FA.9090604@toptica.com>
References: <4AB0C706.5020601@toptica.com>
	<20090916204853.GA21627@pengutronix.de>
	<4AB241FA.9090604@toptica.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 17 Sep 2009 08:13:29 -0600
Message-ID: <fa686aa40909170713v4c447ce2s3b4d18e15a1a2c17@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH] mpc52xx_psc_spi: enlarge clock range
To: Dragos Carp <dragos.carp@toptica.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2009 at 8:04 AM, Dragos Carp <dragos.carp@toptica.com> wrote:
> Hi,
>
> I wasn't aware that MPC5200 differ from MPC5200B in this regard. I also
> couldn't find any MPC5200 user manual on Freescale's webpage.
> Is there a #define that I can use to distinguish between the two
> processor variants? Querying the PVR register is not a nice solution
> because the chip-select activate function is called in some scenarios
> quite often.

Use the compatible value.  That's what it is there for.  Only use the
extended register format if "fsl,mpc5200b-psc-spi" is present in the
compatible list.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
