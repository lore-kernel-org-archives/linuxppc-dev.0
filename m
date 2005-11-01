Return-Path: <i2a@gmx.net>
Received: from vmx10.multikabel.net (vmx10.multikabel.net [212.127.254.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 274316865E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 19:28:45 +1100 (EST)
Received: from vmx60.multikabel.net ([212.127.254.141])
	by vmx10.multikabel.net with esmtp (Exim 4.44) id 1EWrVX-00041C-Mz
	for linuxppc-dev@ozlabs.org; Tue, 01 Nov 2005 09:28:39 +0100
From: "Ingmar" <i2a@gmx.net>
To: Olof Johansson <olof@lixom.net>
Date: Tue, 1 Nov 2005 09:28:31 +0100
Message-Id: <20051101081944.M97356@gmx.net>
In-Reply-To: <20051101014630.GA7938@pb15.lixom.net>
References: <1130645036.29054.229.camel@gaston>
	<20051031002926.M71008@quicknet.nl>
	<2828913a7186e850887d415a8311dc44@penguinppc.org>
	<20051031093907.M8073@gmx.net>
	<20051101014630.GA7938@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > > > I am trying to overwrite the exception vector space of an ibook G4 :).
> > > 
> > > Why?
> > > 
> > 
> > For my thesis project I am porting the Minix (v3) OS.
> 
> Sounds like using qemu or some other emulator to do the PPC port first
> might be an easier choice, and make debugging easier for you during
> early bringup.

I was going to try that, before I got the ibook. Then I got the ibook and I
wanted to get my hand dirty. Nothing beats the real thing :)

But I have figured it out, I have the code working...

It are more or less (just) two things:
 - mmu off,
 - make sure u copy through the cache.

And of course make sure your secondary code is working as it should, then a emu
would help :).

Thanks for the reactions.
  Ingmar
