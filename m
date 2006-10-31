Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add
	MPC52xx	Interrupt	controller	support	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45471B57.6040109@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<1162268830.25682.271.camel@localhost.localdomain>
	<4546F68C.6070900@bplan-gmbh.de>
	<1162279296.25682.297.camel@localhost.localdomain>
	<45470006.1020004@bplan-gmbh.de>
	<1162281518.25682.305.camel@localhost.localdomain>
	<4547093E.6070502@bplan-gmbh.de>
	<1162284291.25682.323.camel@localhost.localdomain>
	<4547119C.3060208@bplan-gmbh.de>
	<1162285628.25682.326.camel@localhost.localdomain>
	<45471B57.6040109@bplan-gmbh.de>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 07:29:32 +1100
Message-Id: <1162326572.25682.330.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-31 at 10:46 +0100, Nicolas DET wrote:
> Benjamin Herrenschmidt wrote:
> >> Ok. that's why I suggest to keep buggy (or none) firmware board in 
> >> platform specific code.
> > 
> > Well, in that case, we have a well defined interface to set the sense
> > code, via the device-tree, and that's much better than having platform
> > code muck around the PIC hardware separately from the PIC driver don't
> > you think ?
> > 
> > Anyway, that's the way it works in Linux/powerpc so there is no need
> > debating that for ever. Just be aware that at one point, there will be a
> > set_type() implementation in this driver and that it will be called
> > based on the polarity information in the device-tree so make sure you
> > got it right.
> > 
> 
> Ok. set_type() is scheduled for later on or should it be included right now?
> What's next should be done to finally acked the driver?

Post the latest one and we'll see..

Ben
