Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C75F767A64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 09:16:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
In-Reply-To: <4240b91605040412117b29d4ca@mail.gmail.com>
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 05 Apr 2005 09:12:52 +1000
Message-Id: <1112656372.26086.88.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-04 at 20:11 +0100, Jerome Glisse wrote:
> > You should really be using a 64 bits kernel :)
> 
> Yes, i should, honte à moi :) btw which distribution
> do you use or recommand for 64bits ? gentoo ? I am
> long time debian user (x86) and i think that this is not the
> best choice for ppc64...

I'm using debian 32 bits and do my own 64 bits toolchain for building
kernels ;)

For toolchain, I recommend Janis scripts at penguinppc64.org (toolchain
section, there is a link to mkbiarch etc... I don't use crosstools).

Ben.
