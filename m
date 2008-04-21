Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id B6A88DE349
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 23:21:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so470361anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 06:21:14 -0700 (PDT)
Message-ID: <fa686aa40804210621h304c051ev3fd3c080dd0b8dda@mail.gmail.com>
Date: Mon, 21 Apr 2008 07:21:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1
	format
In-Reply-To: <20080421084337.GB5618@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
	<20080421084337.GB5618@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, m8@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 2:43 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Apr 18, 2008 at 09:10:04AM -0700, Grant Likely wrote:
>
>
> > Update dts files to current format
>  >
>  > From: Grant Likely <grant.likely@secretlab.ca>
>  >
>  > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>  > ---
>  >
>  >  arch/powerpc/boot/dts/cm5200.dts    |   98 +++++++++++------------
>  >  arch/powerpc/boot/dts/lite5200.dts  |  132 ++++++++++++++++----------------
>  >  arch/powerpc/boot/dts/lite5200b.dts |  146 +++++++++++++++++------------------
>  >  arch/powerpc/boot/dts/motionpro.dts |  118 ++++++++++++++--------------
>  >  arch/powerpc/boot/dts/tqm5200.dts   |   80 ++++++++++---------
>  >  5 files changed, 286 insertions(+), 288 deletions(-)
>  >
>  > diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
>  > index c6ca631..2f74cc4 100644
>  > --- a/arch/powerpc/boot/dts/cm5200.dts
>  > +++ b/arch/powerpc/boot/dts/cm5200.dts
>  > @@ -10,11 +10,7 @@
>  >   * option) any later version.
>  >   */
>  >
>  > -/*
>  > - * WARNING: Do not depend on this tree layout remaining static just yet.
>  > - * The MPC5200 device tree conventions are still in flux
>  > - * Keep an eye on the linuxppc-dev mailing list for more details
>  > - */
>  > +/dts-v1/;
>  >
>  >  / {
>  >       model = "schindler,cm5200";
>  > @@ -29,10 +25,10 @@
>  >               PowerPC,5200@0 {
>  >                       device_type = "cpu";
>  >                       reg = <0>;
>  > -                     d-cache-line-size = <20>;
>  > -                     i-cache-line-size = <20>;
>  > -                     d-cache-size = <4000>;          // L1, 16K
>  > -                     i-cache-size = <4000>;          // L1, 16K
>  > +                     d-cache-line-size = <32>;
>  > +                     i-cache-line-size = <32>;
>
>  Has the standard number format changed to decimal lately? Otherwise this
>  looks wrong. There are more occurences of this in the other dts files.

Yes, that is the major change in v1 of the dts format.  It uses C
style number format.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
