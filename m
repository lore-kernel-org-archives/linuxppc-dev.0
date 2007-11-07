Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FC57DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Nov 2007 09:37:50 +1100 (EST)
Message-ID: <4732396D.4040904@genesi-usa.com>
Date: Wed, 07 Nov 2007 22:17:17 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
In-Reply-To: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> Sometimes the fsl prefix is being used and sometimes it isn't. Look at
> the two compatible strings. Which way is it going to be? Is
> fsl,has-wdt right?

fsl,has-wdt is right, at least since someone changed it.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
