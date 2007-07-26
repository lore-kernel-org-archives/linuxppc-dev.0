Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B45BFDDEDC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 06:13:59 +1000 (EST)
Date: Thu, 26 Jul 2007 22:13:57 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver (was: MMIO IDE driver)
In-Reply-To: <46A8FB86.2010907@ru.mvista.com>
Message-ID: <Pine.LNX.4.60.0707262156250.6614@poirot.grange>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<Pine.LNX.4.60.0707252130090.6234@poirot.grange>
	<20070725213925.2f25906c@the-village.bc.nu>
	<Pine.LNX.4.60.0707262136530.6614@poirot.grange>
	<46A8FB86.2010907@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jul 2007, Sergei Shtylyov wrote:

> Guennadi Liakhovetski wrote:
> 
> > Ok, thanks for the explanation Alan. So, there's no technical argument, 
> > just "being nice to the users", and add a new driver, which we know we'll 
> > have to remove soon, thus having to persuade its users, who by that time 
> 
>     Define "soon". :-)

"Soon" in this case means, we NOW have a replacement driver and we aim at 
deprecating the IDE driver in its favour.

> > will get used to it and will not want to invest money into switching to 
> > another one...
> 
>     Invest into what if the drivers are functionally identical?

For example, into porting user space (replace hdx with sdx). And even 
switching to a "functionally identical" driver requires a new complete 
testing cycle... No, I won't be in that situation, so, it's not my money 
I'm worrying about. But I know there are companies for whom releasing a 
new version of /etc/fstab is a considerable expense... Not that I cared 
about them anyway.

Thanks
Guennadi
---
Guennadi Liakhovetski
