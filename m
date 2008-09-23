Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BB6FDDE08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 14:42:41 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20080922152444.GA9716@yoda.jdub.homelinux.org>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E0DA@insardxms01.ap.sony.com>
	<20080922152444.GA9716@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 14:42:29 +1000
Message-Id: <1222144949.12085.80.camel@pasglop>
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

On Mon, 2008-09-22 at 11:24 -0400, Josh Boyer wrote:
> On Mon, Sep 22, 2008 at 08:45:52PM +0530, Sadashiiv, Halesh wrote:
> >
> >
> >The issue is found only in PPC32.
> >
> >Please let me if the patch is applicable.
> 
> Well, no not really.  Mostly because of procedural issues than anything
> else.  Read Documentation/SubmittingPatches in the kernel directory.
> 
> Also, there is a comment above this function that eludes to some issues
> with select on ppc32.  You might want to ask the overall PowerPC maintainer
> if that issue still exits.

I have only half of this thread, what is the problem ?

Ben.
