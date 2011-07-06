Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AB57B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jul 2011 03:16:10 +1000 (EST)
Received: by pwi18 with SMTP id 18so41061pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Jul 2011 10:16:07 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 6 Jul 2011 11:16:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5200: dts: digsy_mtc.dts: add timer0 and timer1
	gpio properties
Message-ID: <20110706171602.GI5805@ponder.secretlab.ca>
References: <1305561764-5942-1-git-send-email-agust@denx.de>
	<1307399225-15882-1-git-send-email-agust@denx.de>
	<20110706114627.56388c2e@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110706114627.56388c2e@wker>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 06, 2011 at 11:46:27AM +0200, Anatolij Gustschin wrote:
> Hi Grant,
> 
> Can you please pick this patch for 3.1 ?
> 
> On Tue,  7 Jun 2011 00:27:05 +0200
> Anatolij Gustschin <agust@denx.de> wrote:
> 
> > timer0 and timer1 pins are used as simple GPIO on this board.
> > Add gpio-controller and #gpio-cells properties to timer nodes
> > so that we can control gpio lines using available MPC52xx
> > GPT driver.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>

Merged, thanks.

g.

> > ---
> >  arch/powerpc/boot/dts/digsy_mtc.dts |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
> > index e205d17..2aad7ae 100644
> > --- a/arch/powerpc/boot/dts/digsy_mtc.dts
> > +++ b/arch/powerpc/boot/dts/digsy_mtc.dts
> > @@ -23,7 +23,14 @@
> >  
> >  	soc5200@f0000000 {
> >  		timer@600 {	// General Purpose Timer
> > +			#gpio-cells = <2>;
> >  			fsl,has-wdt;
> > +			gpio-controller;
> > +		};
> > +
> > +		timer@610 {
> > +			#gpio-cells = <2>;
> > +			gpio-controller;
> >  		};
> >  
> >  		rtc@800 {
> 
> 
> Thanks,
> Anatolij
