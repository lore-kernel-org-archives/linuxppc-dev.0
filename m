Message-ID: <3AE82655.DADBB0B2@motorola.com>
Date: Thu, 26 Apr 2001 14:44:53 +0100
From: "John Traill" <john.traill@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 SCC as Console
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone have a patch ( Or is working on one ) to use an SCC as a console ?

If not has anyone looked at which changes are required ? I had a quick scan and it would appear to need modifications in m8260_tty.c and the serial_console_xxx functions in uart.c. Are there any 'gotchas' lurking in there.

--

Regards, John
___________________________________________________________________________

John Traill                                   Motorola
Ph.   : +44 (0)1355 355494                    Colvilles Road
Fax.  : +44 (0)1355 261790                    East Kilbride G75 OTG
email : johnt@burton.sps.mot.com              Scotland
      : R17296@email.sps.mot.com

[x] General Business Use
[ ] Motorola Internal Use Only
[ ] Motorola Confidential Proprietary

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
