Subject: MPC8540ADS setup
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1075196173.13554.42.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 10:36:13 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi list,

I have some initial troubles with the MPC8540ADS that
are probably FAQ, but I did not find in the list archives.


1st, whats the correlation between PVR and "Revision"?

My PVR is 0x80200010, the BDI firmware says
Target CPU        : MPC8560/8540 Rev.1,
while u-boot/doc/README.mpc85xxads reads:

"MPC85xx Rev 1 Chip, in general you will use a Rev2
chip from Nov.2003. If you still see this definition
while you have a Rev2(and newer) chip,undef this."

So what Rev do I have? Booby traps on the way?


2nd, how to correctly setup the BDI flash access?

bdi-8540>unlock 0xFF000000
# Writing to workspace failed

I've taken the sections from ads8560.cfg that
seem to map L2SRAM for that purpose and
use WORKSPACE   0xf0000000.

Some working [INIT]-Lines?


3rd, some reset-trouble with the BDI.

It seems I have to do

reset run
g
reset run

every time to reset the board, otherwise it stays dead :(
Not necessary on manual reset and powerup.


Thanks,

-- Stefan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
