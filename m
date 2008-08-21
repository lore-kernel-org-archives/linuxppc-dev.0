Return-Path: <matvejchikov@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id EAC31DEBA8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 23:04:26 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so525136nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 06:04:24 -0700 (PDT)
Message-ID: <8496f91a0808210604r3aab945crb5d4396240aa6b5e@mail.gmail.com>
Date: Thu, 21 Aug 2008 17:04:24 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
In-Reply-To: <20080819161352.GA1735@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
	<20080729193901.GC8051@ld0162-tx32.am.freescale.net>
	<8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
	<20080730154545.GB25428@ld0162-tx32.am.freescale.net>
	<8496f91a0808190413y69817434v2e340454941f97a0@mail.gmail.com>
	<20080819161352.GA1735@ld0162-tx32.am.freescale.net>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> No, the DTS files don't need to be updated -- u-boot (or whatever
> firmware you use, or the bootwrapper) needs to fill in the frequency.

u-boot doesn't contains any related code for this moment...
I think we need to add some code that adds "clock-frequency" property for the
"fsl,cpm-brg" compatible node to the u-boot as it expected in get_brgfreq.

Matvejchikov Ilya.
