MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: More USB questions (for the MPC8xx) 
Date: Tue, 20 Mar 2001 19:08:40 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3108AFEA@kolkrabbi.flaga.is>
From: Kári Davíðsson <karid@flaga.is>
To: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I managed to get the m8xxhci with the TIMER1 patch to sort of work with
my board.
I.e. the SOF seem to be genrated normally and there seem to be some
traffic on
the usb bus when I plug in keyspan_pda USB device. Althoug the
initialization of
the keyspan_pda fails.
I have also tried a MS USBMouse but then the m8xxhci is totally silent
and there
is no traffic on the USB.

What kind of USB devices have you used to plug to a MPC8xx in HIC mode?

Thanks,

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
