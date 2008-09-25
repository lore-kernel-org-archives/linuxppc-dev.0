Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 9F67EDE0D8
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:12:26 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so495235rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:12:24 -0700 (PDT)
Message-ID: <fa686aa40809251112j3512d599i4e8e109d31cc31@mail.gmail.com>
Date: Thu, 25 Sep 2008 12:12:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: MPC5200 PCI interrupt routing
In-Reply-To: <9e4733910809251102i9c87fcfrfc5ae45e90dd07f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200809221556.34353.jbe@pengutronix.de>
	<20080924181542.GA9690@secretlab.ca>
	<1222291345.8277.92.camel@pasglop>
	<200809250951.15941.jbe@pengutronix.de>
	<20080925165755.GB16018@secretlab.ca>
	<9e4733910809251102i9c87fcfrfc5ae45e90dd07f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 12:02 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The new mpc5200 datasheet has removed the option of using a 16x
> multiplier on a 33Mhz crystal and running the core at 528Mhz. The new
> datasheet only allows up to 400Mhz for the core. Anyone know what is
> going on?

You mean other than the 5200b being a slighly dodgy chip to work with?

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
