Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8385B2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 04:40:12 +1100 (EST)
Date: Fri, 3 Dec 2004 09:40:07 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Message-ID: <20041203174007.GA16609@gate.ebshome.net>
References: <45ABD2373C33C4459D42B40EC4F346F2047DC3D4@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F2047DC3D4@FTWMLVEM03.e2k.ad.ge.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2004 at 06:12:31AM -0600, Barbier, Renaud (GE Infrastructure) wrote:
> 
> I am using linux 2.4.26 on a 440GX with 512MB of SDRAM.
> >From U-boot I can see the whole memory.
> If I boot Linux, unless I set the boot parameter mem=256M (or less).
> it will not boot. Linux does not seem to go further than the MMU_setup.
> 
> Any idea why it cannot use 512MB?

Incorrect SDRAM setup? Try running at least simple memory tests.

--
Eugene
