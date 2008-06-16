Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 0FB8DDDF2F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 00:13:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1031368anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 07:13:06 -0700 (PDT)
Message-ID: <fa686aa40806160713q51f3d132w2fef2a2473faad1@mail.gmail.com>
Date: Mon, 16 Jun 2008 08:13:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
In-Reply-To: <20080614175723.209e93dc@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
	<20080614175723.209e93dc@mjolnir.drzeus.cx>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 14, 2008 at 9:57 AM, Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
> On Thu, 5 Jun 2008 20:16:24 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
>
>> Here is v3. I'm out of ideas if you won't like it. :-)
>>
>> v3:
>> - Now these bindings are using bus notifiers chain, thus we adhere to the
>>   spi bus.
>>
>
> Now this was nice and clean. I take it Grant doesn't like this version
> though. What's the downside of it?

No, I don't.  I like the v2 approach better as long as it is been
changed to address your comments.  This approach I think is needlessly
complex and non-obvious (relying on the notification chain instead of
being part of the probe call).  It will break in non-obvious ways if
the notifier module is loaded after the mmc_spi driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
