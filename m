Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 12A03679F3
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 17:49:05 +1000 (EST)
Date: Tue, 25 Apr 2006 00:49:02 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425074902.GA20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 01:08:00AM -0500, Kumar Gala wrote:
> 
> On Apr 24, 2006, at 5:31 PM, Dan Malek wrote:
> 
> >
> > On Apr 24, 2006, at 5:43 PM, Kumar Gala wrote:
> >
> >> However, I am against removing the arch/ppc support until the u-boot
> >> patches are picked up.  I think its bad form to give people a kernel
> >> they can't easily boot.
> >
> > What about systems that can't update u-boot, but want to run
> > a newer kernel?
> 
> Does this situation exist for any in tree boards that are supported?

Kumar, with all due respect, I don't like this attitude. I can have 
eval board where I don't want to upgrade firmware.

Also, this "let's screw everybody who doesn't have their board support 
in tree" is very counter productive. FYI, almost all my contributed 
kernel work was done on custom hardware, not on reference boards.

It seems some people here lost touch with reality - embedded Linux is 
mostly run on custom hardware, not on evaluation boards.

-- 
Eugene
