Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4D6DDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 20:33:06 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070124085420.GA19810@iram.es>
References: <20061213123819.403286000@sipsolutions.net>
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
	<20070124085420.GA19810@iram.es>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 20:32:57 +1100
Message-Id: <1169631177.18754.82.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-24 at 09:54 +0100, Gabriel Paubert wrote:

> Isn't there a way to obtain a better resolution? 

Not that I know.

> The RTC has a resolution on 1 second AFAIR. This means that there will
> be an error of up to 1 second after resume. If you run NTP, it will
> ultimately be corrected (I believe) but it may take a fairly long time
> given the loop bandwidth of NTP, which will also probably write for a
> while crap values into its drift file (/var/lib/ntp/ntp.drift on Debian 
> but location varies with distribution).

But then, people suspending/resuming laptops know what to (or not to)
expect I suppose :-)

Ben.
