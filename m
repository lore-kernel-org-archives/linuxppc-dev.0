Message-ID: <3BEFF427.4000309@embeddededge.com>
Date: Mon, 12 Nov 2001 11:09:11 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE in Mode 1 (Sandpoint) how ?
References: <20011112124640.6795.qmail@mailweb22.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:

> hi all,
> The Sandpoint user's manual says that WinBond's IDE controller is disabled in mode 1 (s3-down, s4-up), but MontaVista's kernel works in mode 1 with IDE support!
> How is this possible ?

The up/down comment is relative to the installation of the board in the chassis.
Mine are actually the other way around.  I'm not even sure if on/off nomenclature
would work.

>  Moreover, the kernel we had built ( not from mVista) runs too too slow.

Sounds like you have the switches in the wrong position and the interrupts
are not routed correctly.  The serial port will eventually time out when it
doesn't receive interrupts, giving the perception of a very slow running system.

Just keep in mind the troubles are local to your configuration, as this software
operates fine on a properly configured board.  Just move switches until it works,
then leave them alone :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
