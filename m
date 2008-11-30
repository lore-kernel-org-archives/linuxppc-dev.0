Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 764ABDDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Nov 2008 22:35:55 +1100 (EST)
Date: Sun, 30 Nov 2008 11:16:14 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc: hv{cs, si}_close() both unsigned hp->count and
	hvcsd->open_count cannot be negative
Message-ID: <20081130111614.21b194c5@lxorguk.ukuu.org.uk>
In-Reply-To: <18737.52782.650416.444270@cargo.ozlabs.ibm.com>
References: <4931201D.7060701@gmail.com>
	<18737.52782.650416.444270@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: roel kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Also, I don't see why those changes have anything to do with "unsigned
> things cannot be negative".  As long as those counts are never zero on
> entry to those code sections, the existing code is fine, and I believe
> that assertion can be maintained.  If you believe the code needs to
> defend against the possibility of a zero count on entry, that should
> have been explicitly stated in the patch description.

See the tty_port patches in -next - this is an argument about code which
ought eventually to go away replaced by standard helper functions.
