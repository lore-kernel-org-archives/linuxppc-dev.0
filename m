Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 999562BDCF
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 02:33:13 +1000 (EST)
Date: Wed, 22 Sep 2004 09:33:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Message-ID: <20040922163309.GL16619@smtp.west.cox.net>
References: <414916BD.9080607@sonartech.com.au>
	<20040915223624.A25752@home.com>
	<414946A0.1020306@sonartech.com.au>
	<20040920173241.GL27914@smtp.west.cox.net>
	<20040920122312.A8344@home.com> <414F5FED.6070107@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414F5FED.6070107@sonartech.com.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2004 at 08:55:41AM +1000, David Gardiner wrote:

> Okay I took a different way, looking at the code and having lots of 
> problems trying to get it to compile and the similarity between the 
> PowerPlus series I compiled a pplus kernel with the default config and 
> the patch above and it booted, yeah, and dumped bits to the console, on 
> an mvme2604.
> 
> So I made some changes Kconfig so that MVME5100 and PPLUS were basically 
> the same ( The architecture for the 5100 and pplus are similar, so why 
> was the code separated? arrgh I'm about to be burnt to a crisp, but if 
> we don't get our fingers burnt we never learn) which the patch for is 
> attached. This patch also allows the selection of nvram which I want 
> also and it seems to compile no matter what you select, which it didn't 
> before. And so selecting MVME5100 it booted and dumped bits to the 
> console, yeah.

I _think_ the answer is simply that the mvme5100 work predated the
CONFIG_PPLUS work.  If you can come up with a patch that adds mvme5100
support to CONFIG_PPLUS, we can get rid of the MVME5100-specific stuff.
(And, if you do, please look at Documentation/SubmittingPatches and the
Developers Certificate of Origin).

> I'm still playing with the config, so please excuse the "weird" 
> selections in the config which is also attached, but the notable 
> differences between it and the arch/ppc/configs/mvme5100_defconfig are 
> that it has selections for a default console, and input devices ( which 
> isn't needed, I know)  and .....

I'll try and pick out the important changes and push them up.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
