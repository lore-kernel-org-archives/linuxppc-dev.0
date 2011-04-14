Return-Path: <mikpe@it.uu.se>
Received: from fanny.its.uu.se (fanny.its.uu.se [130.238.4.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89BA7B6FDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 08:14:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19879.29101.783037.726594@pilspetsen.it.uu.se>
Date: Fri, 15 Apr 2011 00:14:05 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Hugh Dickins <hughd@google.com>
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
In-Reply-To: <BANLkTimykvKp=bwsFyNE9fWqcE9Ffws6bA@mail.gmail.com>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop>
	<1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
	<1302736869.28876.91.camel@pasglop>
	<BANLkTika8FY1dD_hOQ4wMhHzuQ2Qt8fg7A@mail.gmail.com>
	<1302771756.15520.100.camel@thor.local>
	<BANLkTimykvKp=bwsFyNE9fWqcE9Ffws6bA@mail.gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jens Axboe <jaxboe@fusionio.com>,
	linux-kernel@vger.kernel.org, kevin diggs <diggskevin38@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Apr 2011 14:25:31 -0700, Hugh Dickins wrote:
> Mikael,
> 
> Something worth trying: turn off CONFIG_IDE.  That's what I need to
> boot 2.6.39-rc[1-3] on PowerPC G5.
> 
> I know Jens has been fixing problems with IDE versus his plug/unplug
> changes, but it's still not fixed for me in rc3.
> 
> In other mail http://lkml.org/lkml/2011/4/14/614
> I see Linus recommending his post-rc3 commit 6631e635c65d
> but I've not tried that myself yet.
> 
> Hugh

Hugh,

With CONFIG_IDE disabled I could finally boot 2.6.39-rc3 on my G5.
I lost the DVD drive, but that's fine for now.

Thanks!

/Mikael
