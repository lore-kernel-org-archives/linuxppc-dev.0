From: "okisoftxman" <okisoftxman@hotmail.com>
To: "linux-emb" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Callebaut, Benoit" <benoit.callebaut@barco.com>
Subject: problem about RAM assigned
Date: Mon, 24 Feb 2003 12:10:56 +0900
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <OE23ugEzUfctANq8qTF0000e377@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I have some problem about allocate RAM on MBX860 board.Who can tell me
,Thank you.
1.when we power-up the system and PPCBOOT run successfully,I find there are
some codes in the top of the RAM(the address about 0x0--0x2000).I guess it
is the PPCBOOT's code.But my "PPCBOOT.BIN"in FLASH is about 150kbytes,and
the size is bigger than the codes in RAM,why?

2.Someone told me that after LINUX booted,PPCBOOT is invalid and the RAM
will relocate.But as I known,some functions of PPCBOOT (e.g.FLASH WRITE
,SDRAM control)is most important and there is no similar functions in
LINUX.If PPCBOOT will be invalid and relocate RAM,LINUX how to control these
function(e.g.flash write,SDRAM control)?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
