Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4621DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 12:36:30 +1000 (EST)
Subject: RE: help on dts compiler please.
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A45A@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A45A@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 21:32:20 -0500
Message-Id: <1183429940.9030.1.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
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

On Mon, 2007-07-02 at 18:49 -0700, Bizhan Gholikhamseh (bgholikh) wrote:
> > > $ dtc -f -I dts -O dtb mpc8541cds.dts
> > > DTC: dts->dtb  on file "mpc8541cds.dts"
> > > syntax error at line 15
> > > FATAL ERROR: Couldn't read input tree
> > 
> > Where did you get your dtc version from?
> > 
> Sorry I answered the question wrong. I downloaded the gzip tar file from
> David Gibson web page.

That is a very out of date dtc.  Try using the one found here:

git://www.jdl.com/software/dtc.git

josh
