Message-ID: <E69FF45ADA3BD511A25900047623CC4F12AA7B@JUPITER>
From: Neil Wilson <NWILSON@Airspan.com>
To: "'Mark A. Greer '" <mgreer@mvista.com>,
	Neil Wilson <NWILSON@Airspan.com>
Cc: "''linuxppc-embedded@lists.linuxppc.org' '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Sandpoint 3 + MPC7450 + HHL2
Date: Thu, 28 Jun 2001 21:15:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Are you sure you want to do this???  The intsenses stuff in
>sandpoint_setup.c is the way it is for a very good reason.  Can you send
>me your patch so I can take a look?  Also, can you send the switch
>settings that you are using.

Okay, when I work out how to do patches, I am new at this stuff.  It was
just changing the offset argument value in the function call.

As it is an SP3 the switch settings don't sort of match up to SP2 which I
think is what the build is aimed at in the first place, but the switch
settings are (for the 7450 card) :-

SW2-1:  ON      RCS0 on PCI
SW2-2:  OFF     Map B / CHRP
SW2-3:  ON      MOT MPPMC
SW2-4:  ON      Free agent
SW2-5:  OFF     Local flash is bootable
SW2-6:  OFF     Standard flash selected
SW2-7:  ON      33MHz PCI
SW2-8:  OFF     COP resets MPPMC only

SW1 on the 7450 card and SW1 & 2 on the SP3 motherboard are set to the
Motorola defaults.

>I think that your sandpoint-specific boot head.S or somewhere else like
>that would be a much better choice than the ppc-generic decompress_kernel
>routine.

Yes that would be more sensible.

>Let's hold off on this until people who have sandpoints can take a look.

Okay.

Neil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
