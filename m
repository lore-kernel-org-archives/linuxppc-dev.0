Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C84C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 10:27:16 +1100 (EST)
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <0E5CD213-9ADE-4C49-9BD1-1DE96830F65E@kernel.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<200911222327.37949.arnd@arndb.de> <1259212468.16367.267.camel@pasglop>
	<0E5CD213-9ADE-4C49-9BD1-1DE96830F65E@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 10:27:07 +1100
Message-ID: <1259278027.2659.5.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 23:54 +0100, Segher Boessenkool wrote:
> No Ben.  The whole point of EARLY_DEBUG is that it _always works_,  
> because
> it is such trivial code.  Don't break that please, or we'll be forced to
> add a "REALLY_EARLY_DEBUG" instead :-) 

I do tend to agree but heh... temptation to do more cute hacks ... :-)

Cheers,
Ben.
