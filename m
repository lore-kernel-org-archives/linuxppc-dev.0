Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C7799DDF46
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 23:29:07 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 19 Jun 2007 15:29:06 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <bec0a23b1a544fe66810f43a73b142a2@kernel.crashing.org>
Message-ID: <20070619132906.202110@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
	<73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
	<20070619095251.202080@gmx.net>
	<81b5cc3c799c9ec65df04468d4d9051e@kernel.crashing.org>
	<20070619123721.202110@gmx.net>
	<bec0a23b1a544fe66810f43a73b142a2@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Tue, 19 Jun 2007 15:15:33 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> "compatible" = "serial" is completely wrong -- it is
> a generic name and should never be matched on.
Doh again! Looks like I'm absent-minded today.

> > Downloaded the file you pointed to and the OF generic names document. I
> > thought the OF core specification defines them, but it's not available
> > freely.
> 
> That's a common misconception :-)
> 
> <ftp://playground.sun.com/pub/p1275/coredoc/1275-1994/1275.ps.gz>
So much for "available commercially". :-) Thanks!

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
