Return-Path: <airlied@linux.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83041DE0AC
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 20:15:10 +1100 (EST)
Date: Tue, 3 Feb 2009 09:06:30 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
In-Reply-To: <1233651720.16867.82.camel@pasglop>
Message-ID: <alpine.DEB.2.00.0902030906160.31073@skynet.skynet.ie>
References: <20090202055559.8D600DDF51@ozlabs.org>
	<1233608464.4932.15.camel@gaiman>
	<1233609688.18767.118.camel@pasglop>
	<21d7e9970902030039n786b831dm4395b802e0c87b45@mail.gmail.com>
	<1233651720.16867.82.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@gmail.com>,
	dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> BTW. Do you guys want me to remove the drm_local_map_t typedef
> completely in favor of struct drm_local_map ? I have a patch here going
> part way through that, it's fairly trivial, so if you want it, I can
> easily finish it.

One less typedef is always welcome.

Dave.
> 
> Cheers,
> Ben.
> 
> 
> 
> ------------------------------------------------------------------------------
> Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
> software. With Adobe AIR, Ajax developers can use existing skills and code to
> build responsive, highly engaging applications that combine the power of local
> resources and data with the reach of the web. Download the Adobe AIR SDK and
> Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 
> 
