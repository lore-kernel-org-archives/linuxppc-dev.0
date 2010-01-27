Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D94CB804D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 03:15:59 +1100 (EST)
Subject: Re: [PATCH 0/3 for 2.6.33] Some fixes for kfifo and FHCI
From: Stefani Seibold <stefani@seibold.net>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20100127145054.GA24673@suse.de>
References: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
	<20100127145054.GA24673@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Wed, 27 Jan 2010 16:47:39 +0100
Message-ID: <1264607259.8302.0.camel@wall-e>
Mime-Version: 1.0
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, den 27.01.2010, 06:50 -0800 schrieb Greg KH:
> On Wed, Jan 27, 2010 at 05:08:09PM +0300, Anton Vorontsov wrote:
> > Hi all,
> > 
> > FHCI no longer builds after kfifo rework, this patch set is
> > used to fix the issues.
> 
> If there are no objections to these, I'll queue these up and send them
> through my tree as they affect the FHCI driver.
> 

Looks good for me, so
Acked-by: Stefani Seibold <stefani@seibold.net>
