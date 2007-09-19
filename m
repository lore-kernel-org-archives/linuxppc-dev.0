Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id D489DDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 14:56:26 +1000 (EST)
Date: Wed, 19 Sep 2007 06:56:25 +0200
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Jtag under Linux on MPC875
Message-ID: <20070919045625.GA24471@powerlinux.fr>
References: <f8f856500709180204r165d7b9dp4a8805dbfbe84d45@mail.gmail.com>
	<20070918144905.GF441@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918144905.GF441@ld0162-tx32.am.freescale.net>
From: Sven Luther <sven@powerlinux.fr>
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

On Tue, Sep 18, 2007 at 09:49:05AM -0500, Scott Wood wrote:
> On Tue, Sep 18, 2007 at 11:04:27AM +0200, fabien wrote:
> > I'm new in embedded system and i need some informations ...
> > Which tool could i use to connect my board througt the JTAG connector ?
> > My board is a custom board with a MPC875, and flash is S29GL032M. The probe
> > that can i use is
> > a PowerPC BDM windriver Probe 2.
> > I'm looking for a tool running on linux.
> 
> The Abatron BDI2000 works well with Linux.

Indeed, but i was not able to put my MPC875 board in halt state once linux
started running. I hear Vitaly has had similar problems too.

Wolfgang said it worked though, so this may be due to a hardware quirk
or some misconfiguration or something. I am not really a bdi config file
expert myself.

Friendly,

Sven Luther
