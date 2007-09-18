Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 21879DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 09:21:24 +1000 (EST)
Date: Tue, 18 Sep 2007 09:49:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: fabien <fabien.fb@gmail.com>
Subject: Re: Jtag under Linux on MPC875
Message-ID: <20070918144905.GF441@ld0162-tx32.am.freescale.net>
References: <f8f856500709180204r165d7b9dp4a8805dbfbe84d45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8f856500709180204r165d7b9dp4a8805dbfbe84d45@mail.gmail.com>
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

On Tue, Sep 18, 2007 at 11:04:27AM +0200, fabien wrote:
> I'm new in embedded system and i need some informations ...
> Which tool could i use to connect my board througt the JTAG connector ?
> My board is a custom board with a MPC875, and flash is S29GL032M. The probe
> that can i use is
> a PowerPC BDM windriver Probe 2.
> I'm looking for a tool running on linux.

The Abatron BDI2000 works well with Linux.

-Scott
