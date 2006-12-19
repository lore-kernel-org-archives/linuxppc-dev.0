Return-Path: <SRS0+f7c478659b117b62100c+1213+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FF7FDDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 01:29:37 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: David Woodhouse <dwmw2@infradead.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <4587D338.7060906@246tNt.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 14:29:13 +0000
Message-Id: <1166538553.25827.99.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: bbrv@genesi-usa.com, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-19 at 12:55 +0100, Sylvain Munaut wrote:
> Benjamin Herrenschmidt wrote:
> > On Tue, 2006-12-19 at 09:54 +0000, David Woodhouse wrote:
> >   
> >> The Efika matches chrp_probe() too, so put its own probe first to make
> >> sure we get it right in a multiplatform build.
> >>     
> >
> > Hrm... I told them to remove that from their device-tree ... dammit !
>
> Yes, I told them to do some other changes to their device-tree, but no
> luck so far.

OK, let's drop the patch and assume the device-tree will be fixed
shortly. In the meantime, users should be able to work around it by
hacking the device-tree from the OF prompt -- which we currently have to
do for other things in the Efika device-tree anyway.

I'm happy enough for Fedora to require the fixed firmware, certainly. 

-- 
dwmw2
