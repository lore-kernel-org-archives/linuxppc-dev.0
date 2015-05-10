Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF811A0017
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 08:13:47 +1000 (AEST)
Message-ID: <1431296015.13039.12.camel@kernel.crashing.org>
Subject: Re: G5 Xserve rackmeter broken?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 11 May 2015 08:13:35 +1000
In-Reply-To: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
References: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-05-10 at 21:32 +0300, Aaro Koskinen wrote:
> Hi,
> 
> With 4.1-rc2 the rackmeter driver for G5 Xserve is giving bogus
> led patterns. So far I have seen at least the following:
> 
> a) With static load the leds seems to be sane and report CPU
> usage properly, but after few minutes they go completely OFF,
> even if the CPU load remains high.
> 
> b) On a completely idle system, leds alter between all OFF and all ON
> roughly once a second.
> 
> Unfortunately I cannot say which was the last kernel where this worked
> properly... These servers were away from normal use for a while due
> to PSU issues.

And mine is dead due to ... PSU issue :-(

It could be that what we use to get the "idle time" isn't correct
anymore...

Ben.
