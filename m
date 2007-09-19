Return-Path: <l.butterz@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 0C1C5DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 00:50:09 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so553661pyi
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 07:50:07 -0700 (PDT)
Message-ID: <53b5d6e90709190750tfa894a5jfec4725d13dc433@mail.gmail.com>
Date: Wed, 19 Sep 2007 18:50:07 +0400
From: "Leopold Stotch" <l.butterz@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: PSC in UART mode on TQM5200S
In-Reply-To: <fa686aa40709190733ufd38f1fx7771bd0e98376081@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <53b5d6e90709180313n7ef053ddqfb771f44d9bd44ef@mail.gmail.com>
	<fa686aa40709180701w17273a11wda8c9ece79aad483@mail.gmail.com>
	<53b5d6e90709182355y17fd5965u5f212be74068442e@mail.gmail.com>
	<fa686aa40709190733ufd38f1fx7771bd0e98376081@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks, i'll try the both ways.
I'm still afraid of killing factory UBoot without
BDI2000 or working X30 jumper :-)

On 9/19/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 9/19/07, Leopold Stotch <l.butterz@gmail.com> wrote:
> > Thank you for the answer, Grant !
> > I knew nothing about port_config register before your answer :-(
> > I haven't changed any processor registers yet
> > because i'm still searching where i can do this.
> > Can you tell me, is it UBoot specific or kernel specific or both ?
> > And i already know about MPC5200's device tree in 2.6.x kernel but not in
> > 2.4.x...
>
> It is best to do it in u-boot; but if you cannot (or don't want to)
> change your u-boot image, then you can fix up the port_config value
> during early kernel boot.
>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Best regards,
Leopold Stotch
