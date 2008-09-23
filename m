Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A384DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 19:08:31 +1000 (EST)
Subject: RE: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 19:07:33 +1000
Message-Id: <1222160853.12085.136.camel@pasglop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
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

On Tue, 2008-09-23 at 12:46 +0530, Sadashiiv, Halesh wrote:
> 
> >-----Original Message-----
> >From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> >Sent: Tuesday, September 23, 2008 12:00 PM
> >To: Arnd Bergmann
> >Cc: linuxppc-embedded@ozlabs.org; Sadashiiv, Halesh
> >Subject: Re: Regarding select() on PPC
> >
> >On Tue, 2008-09-23 at 08:01 +0200, Arnd Bergmann wrote:
> >> No, sorry, I don't have a git history that I can search for that.
> >> I have a strong guess that it would be the end of the last century
> >> though, probably before 2.3.48, since the comment in there already
> >> refers to legacy binaries.
> >
> >Yeah, I'm keen to rip it out.
> 
> Means argument checking in ppc_select() can be removed??
> Than shall I post patch to linuxppc-dev@ozlabs.org

ppc_select can probably be removed alltogether and ppc32_select too

Ben.
