From: clark@esteem.com
Message-Id: <1.5.4.32.20000719011945.006845c0@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 18 Jul 2000 18:19:45 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: Do I shoot myself in the foot first or HEAD.S?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


        Hey,

        Any tips for a new guy? I just about ready to start trying to port
linux to our custom MPC850 board.

        This is where I stand right now. I have at my disposal a MBX860
which I have managed to get linuxPPC to boot on. I have a copy of Hard Hat
Linux Journeyman Edition. I also have an EST VisionICE in circuit emulator.

        Now for the questions.

1. Is there a FAQ or Doc on porting the kernel to a new design? (please mail
or direct me to it)

2. Does anyone know if Hard Hat has any problems with Mandrake 7.0 linux?

3. What do I need to do in the ROM before jumping to HEAD.S other than
programming the ram timmings in the UPM( I assume HEAD.S is where everything
starts )?

4. Has any one managed to get an EST VisionICE in circuit emulator to work
with linuxPPc? If so How? Would I be better off using the GNU Debuger?


Many many thanks if you can answer any of these questions for me.

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
