Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AC88DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 16:30:19 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200809230801.33508.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E14C@insardxms01.ap.sony.com>
	<200809230746.03234.arnd@arndb.de> <1222149361.12085.101.camel@pasglop>
	<200809230801.33508.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 16:29:49 +1000
Message-Id: <1222151389.12085.105.camel@pasglop>
Mime-Version: 1.0
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-23 at 08:01 +0200, Arnd Bergmann wrote:
> No, sorry, I don't have a git history that I can search for that.
> I have a strong guess that it would be the end of the last century
> though, probably before 2.3.48, since the comment in there already
> refers to legacy binaries.

Yeah, I'm keen to rip it out.

Ben.
