Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FA3167BF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 09:41:14 +1100 (EST)
Message-ID: <455E3A7E.3030807@garzik.org>
Date: Fri, 17 Nov 2006 17:41:02 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
References: <11637151391017-git-send-email-tnt@246tNt.com>
	<200611172049.49260.jarno.manninen@tut.fi>
	<455E0907.8000009@246tNt.com>
In-Reply-To: <455E0907.8000009@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
> Since the current libata doesn't really support overriding IO accessors,
> I'd keep it like
> that for now. Apparently some other architecture needs special IO stuff
> so we could see
> a way to hook io accessor soon, and then we can change it if we notice
> big problems.

Sure it does...  there are no individual outb etc. hooks, but you can 
override every available bitbang function.  This is intentional, so that 
arches have more power to control when and how a set of registers is 
blasted to the hardware.

	Jeff
