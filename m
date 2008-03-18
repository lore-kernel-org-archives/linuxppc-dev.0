Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.243])
	by ozlabs.org (Postfix) with ESMTP id F2325DE164
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:53:49 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9603954agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 09:53:48 -0700 (PDT)
Message-ID: <fa686aa40803180953v7b704cf4g484324ef6fc8f523@mail.gmail.com>
Date: Tue, 18 Mar 2008 10:53:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <1205858510.7500.35.camel@dax.rpnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47DF7D6F.8010808@semihalf.com>
	<fa686aa40803180747u532f6a0bq1e64e01662bdb6bd@mail.gmail.com>
	<1205858510.7500.35.camel@dax.rpnet.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 10:41 AM, Richard Purdie <rpurdie@rpsys.net> wrote:
>
>  On Tue, 2008-03-18 at 08:47 -0600, Grant Likely wrote:
>  I don't mind having a specific driver but I don't know anything about
>  the hardware its creating the interface for so I need the community's
>  help with that part. There is drivers/leds/leds-gpio.c if that would
>  work better.

Yes, I think that would be the right approach.  We would need to add
the binding code to translate from the OF device tree to the leds-gpio
driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
