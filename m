Subject: Re: Lite5200 PCI not working
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Kate Alhola <kate@iti.fi>
Cc: Wolfgang Denk <wd@denx.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40E3F73A.60607@iti.fi>
References: <20040701091858.A3564C109F@atlas.denx.de>
	 <40E3F73A.60607@iti.fi>
Content-Type: text/plain
Message-Id: <1088685514.6235.78.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 14:38:34 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-01 at 13:36, Kate Alhola wrote:
> >I've updated the table to include  the  settings  for  the  Rev.  4.0
> >board, too, and to list ALL jumpers on the board.
> >
> >
> >
> >>OK. Please see http://www.denx.de/twiki/bin/view/DULG/CoralPInstallation

Great documentation, thanks!

> I have Rev 3.0 board with analog switch type EL4331. To get it working
> even in bypassed mode
> it needs PD ( Power down ) input in pin 14 to grounded ( connect example
> to pin 10 ).

The Rev 5.0 board has J251 "PDN EN" (apparently documented nowhere
except for the DULG) for that purpose. When set, Pin 14 is grounded.

But it didn't help much. I took random shots at the CORALVO[RGB] signals
on the extension connector, and even there, the red and green channels
are only half the amplitude as the blue channel with a typical
grey-on-black linux startup screen. The picture also looks dim-blueish.

I think I'll try the board in a Windows box in the next step ...

> With this modification my board works.  I am running Embedded QT but it
> looks a like that
> #define QT_QWS_REVERSE_BYTE_ENDIANNESS in
> qt-embedded-free-3.3.2/src/kernel/qgfxraster_qws.cpp was not enough to get
> colours right. Needs just more hacking code for fixing endianes problem.

We're running qte 3.1.1 on the Asilient chip (cpu is MPC8245),
and we didn't have to hack Qt for this, hmm ...

--
Stefan Nickl
Project Engineering
Kontron Modular Computers
Sudetenstr. 7
D-87600 Kaufbeuren
Phone ++49/8341/803-294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
