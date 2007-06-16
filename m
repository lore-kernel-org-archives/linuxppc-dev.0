Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C28BDDE08
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 00:09:10 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Powerbook hard shutdown after boot if it's hot
Date: Sat, 16 Jun 2007 16:09:00 +0200
References: <200706141739.12754.mb@bu3sch.de> <200706161504.41168.mb@bu3sch.de>
	<eb7515dbdeec906704d8139424ceee4a@kernel.crashing.org>
In-Reply-To: <eb7515dbdeec906704d8139424ceee4a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706161609.00302.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 16 June 2007 15:40:39 Segher Boessenkool wrote:
> > I think this powerdown is not really related to the adt chip/driver.
> > I think it's more likely some PMU issue and the PMU forces the machine
> > down. How's the PMU involved into temperatures? Does it get
> > the temperature values from the adt chip?
> 
> It is connected to the overtemp alarm interrupt pin of
> the temperature sensors at least.
> 
> Does this shutdown only happen if you boot Linux while
> you were running Linux before, too?

No, it also happens, if I heat up the machine in OSX
and boot linux. Booting OSX does not cause it, then.

-- 
Greetings Michael.
