Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1931DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Sep 2007 03:23:04 +1000 (EST)
Date: Fri, 21 Sep 2007 12:22:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: USB on MPC885 vs. MPC850/823
Message-ID: <20070921172252.GA23602@ld0162-tx32.am.freescale.net>
References: <46F36C01.1040401@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46F36C01.1040401@grandegger.com>
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

On Fri, Sep 21, 2007 at 09:00:17AM +0200, Wolfgang Grandegger wrote:
> I heard that the MPC885 has an improved USB hardware/firmware compared 
> to the one on the rather old MPC823 or MPC850. Is it similar to the USB 
> on the MPC8272? It would be nice, if somebody could shed some light on 
> the usability and the support of USB in Linux for the MPC885 (or similar 
> MPC8xx chips).

I don't think there's any support in Linux for CPM USB.

-Scott
