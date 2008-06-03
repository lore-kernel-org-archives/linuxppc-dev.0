Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8936DDDFD8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 22:07:33 +1000 (EST)
Date: Tue, 3 Jun 2008 16:07:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH] booting-without-of: add FHCI USB, FSL MCU, FSL UPM
	and GPIO LEDs bindings
Message-ID: <20080603120730.GA28457@polina.dev.rtsoft.ru>
References: <20080602182422.GA8620@polina.dev.rtsoft.ru>
	<48450B8B.9000702@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <48450B8B.9000702@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 11:14:51AM +0200, Wolfgang Grandegger wrote:
> Anton Vorontsov wrote:
> > Hi all,
> > 
> > Here are the notorious bindings. I believe I addressed Segher's comments.
> > 
> > Major changes are in the LEDs bindings, I removed all the cruft and now
> > using "aliases" mechanism to determine LEDs' trigger.
> > 
> > Comments, suggestions?
> 
> On what GIT tree is this patch based on?

This is just RFC, so it does not meant to be applicable.
Though, it should apply cleanly on top of this series:

Date: Fri, 23 May 2008 20:38:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 0/7] Patches for Kumar's powerpc-next tree
