Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (licentiaten.umea.hsb.se [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id 8206967A7C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 06:47:37 +1100 (EST)
Date: Mon, 14 Feb 2005 20:47:34 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: Jan Damborsky <jan.damborsky@devcom.cz>
In-Reply-To: <42109B82.9070604@devcom.cz>
Message-ID: <Pine.LNX.4.50.0502142045070.28518-100000@220a.licentiaten.umea.hsb.se>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
	<42109B82.9070604@devcom.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Support for Adder875 in Linux 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 14 Feb 2005, Jan Damborsky wrote:

> Markus Westergren wrote:
>
> >Hi,
> >
> >I'm working on a project which will use hardware based on Analogue & Micro
> >Adder875 module together with Linux 2.4.
> >
> >I use RedBoot as bootloader and kernel 2.4.27-pre1, both came with the Adder
> >module.
> >
> >The project require:
> >
> > - dual ethernet support with AM79C874 PHY
> >   The driver I've found (fec.c) only supports one ethernet. I'v started
> >	modifying a newer version of this driver which have support for my PHY. I
> >	have made some progress but it's not working yet. Found out that the first
> >	FEC is used to communicate with both PHY's. Both devices are detected
> >	correctly and the first seems to work but the second hangs the kernel when
> >	the first packet is sent or received.
> >
> >
> We use our proprietary board with MPC880, dual ethernet + Am79C874 PHY.
> Kernel 2.4.25  (linuxppc_2_4_devel checked out from www.denx.de). Original
> source tree supports only one FEC, but with minor ugly hack we utilize
> both MPC880 FECs
> without problem. If interested, I can send you a patch for get 2nd FEC
> working.
>
I got my board working with both ethernet ports today. I'm interested in your
patch so that I can see if we made the same ugly hack and if I have overlocked
something :)

/Markus
