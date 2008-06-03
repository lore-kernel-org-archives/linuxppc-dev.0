Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D7649DE420
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 19:14:54 +1000 (EST)
Message-ID: <48450B8B.9000702@grandegger.com>
Date: Tue, 03 Jun 2008 11:14:51 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH] booting-without-of: add FHCI USB, FSL MCU, FSL UPM
	and	GPIO LEDs bindings
References: <20080602182422.GA8620@polina.dev.rtsoft.ru>
In-Reply-To: <20080602182422.GA8620@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi all,
> 
> Here are the notorious bindings. I believe I addressed Segher's comments.
> 
> Major changes are in the LEDs bindings, I removed all the cruft and now
> using "aliases" mechanism to determine LEDs' trigger.
> 
> Comments, suggestions?

On what GIT tree is this patch based on?

Wolfgang.
