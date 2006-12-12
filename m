Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4B1C967BA1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:03:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 8/15] Supporting PCI bus and base of I/O
Date: Wed, 13 Dec 2006 00:03:28 +0100
References: <200612120338.kBC3c08S020556@toshiba.co.jp>
	<200612122103.41597.arnd@arndb.de>
	<1165956554.11914.54.camel@localhost.localdomain>
In-Reply-To: <1165956554.11914.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612130003.28650.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 21:49, Benjamin Herrenschmidt wrote:
> 
> > The code looks good to me, I guess it could go in, except that
> > I really don't like the concept of faking a PCI bus device when
> > it's not actually there. I guess the EPCI part of this is
> > not controversial, so it would be good if you can split that
> > out into a separate patch that we can merge first.
> 
> I personally don't have a big problem with the fake PCI stuff. The
> spider and USB drivers are already working out of the box pretty much
> with PCI and that's exactly what we do on IBM blades (though the
> illusion is maintained by the firmware in our case).

Ok, fair enough. Then let's take these patches as well.

> I agree that in the long run, it's better to move that to of_platform,
> but I wouldn't nack the patches for that.

Another alternative might be for the BEAT developers to access the
config space of all buses using an hcall abstraction, but that's
something that is not in the hand of the Linux people.

	Arnd <><
