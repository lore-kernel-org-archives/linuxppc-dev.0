Return-Path: <SRS0+9a5c2b059e868a1fbbba+1599+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83B86DE145
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:49:25 +1100 (EST)
Subject: Re: add phy-handle property for fec_mpc52xx
From: David Woodhouse <dwmw2@infradead.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4784E78C.40904@genesi-usa.com>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 15:49:17 +0000
Message-Id: <1199893757.2978.73.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-01-09 at 15:26 +0000, Matt Sealey wrote:
> If anyone wants to help/assist/suggest any updates to efika.forth,
> create binary tools which assist the installation of the script for
> users and for placement on Linux distro CDs etc. I would be very
> grateful, but it seems we have hit the Wall of Apathy where users
> complain for a feature but are not willing to work for it.

We're already shipping efika.forth in Fedora rawhide, and in my updated
spins of Fedora 8. It's a pain in the arse, but it kind of works.

It would be much better if the kernel would 'just work'. The ideal way
of achieving that is for the firmware to be fixed -- but that's been
promised for a long time now, and we just don't believe you any more. So
working round it in the kernel seems to be the next best option.

> (I am invoking the Open Source Fallacy of that if the source is
> available you can patch it, I say that patching Linux is not the
> solution, but patching the firmware is. But nobody is willing to
> work on patching the firmware and keeping Linux entirely independant
> of our so-deemed "crappy" firmware)

/me looks at http://git.infradead.org/?p=openfirmware.git
/me looks at the Efika...

-- 
dwmw2
