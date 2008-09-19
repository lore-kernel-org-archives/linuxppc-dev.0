Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 201CBDDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 21:26:03 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 19 Sep 2008 13:26:02 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20080919112602.291410@gmx.net>
MIME-Version: 1.0
References: <1221814210-4738-1-git-send-email-jacmet@sunsite.dk>
Subject: Re: [PATCH v2] bootwrapper: support u-boot multi component images
To: Peter Korsgaard <jacmet@sunsite.dk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Fri, 19 Sep 2008 10:50:10 +0200
> Von: Peter Korsgaard <jacmet@sunsite.dk>
> An: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
> Betreff: [PATCH v2] bootwrapper: support u-boot multi component images

> From: peter Korsgaard <jacmet@sunsite.dk>
> 
> Support uImage.<platform>, which are U-Boot multi component images
> containing a kernel, dtb and possibly an initrd.
Just out of interest: Do you intend to replace the code for building
cuImage.<platform> (zImage target) with this new build target?

regards,

Gerhard

-- 
GMX Kostenlose Spiele: Einfach online spielen und Spaﬂ haben mit Pastry Passion!
http://games.entertainment.gmx.net/de/entertainment/games/free/puzzle/6169196
