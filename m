MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Unexpected sleep on old iBook
Date: Wed, 20 Nov 2002 12:11:45 +0100
Message-ID: <2C5637A6A7CE844EA3C0A94565479F5275A2E7@dest-as20-002.int.bauer-partner.com>
From: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>
To: "Ethan Blanton" <eblanton@cs.ohiou.edu>,
	"linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Ethan Blanton [mailto:eblanton@cs.ohiou.edu]
> Sent: Dienstag, 19. November 2002 21:34
>...
> If I can provide any information that might be useful, please let me
> know.  I have both of these laptops sitting in the same room with me
> pretty much every day of the world for at least some period of time.
>
Ok, when I do
	pmud -ds 2>&1 | tee pmud.txt
I get:
pmud[1226]: pmud [treshold = 420, margin = 15] started
pmud[1226]: opening /dev/adb
pmud[1226]: opening /dev/pmu
pmud[1226]: pmu_op(0xea, ..., version req)
pmud[1226]: PMU version 12: iBook/G3 Pismo/G4 Titanium
pmud[1226]: starting monitoring loop
pmud[1226]: pmu_op(0xdc, ..., switch req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: timeleft = -1
pmud[1226]: running /etc/power/pwrctl maximum ac
pmud[1226]: PMU interrupt:
pmud[1226]:  40
pmud[1226]:  14
pmud[1226]: pmu_op(0xdc, ..., switch req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: timeleft = -1
... several seconds later ...
pmud[1226]: PMU interrupt:
pmud[1226]:  40
pmud[1226]:  14
pmud[1226]: pmu_op(0xdc, ..., switch req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: pmu_op(0x6f, ..., smart battery req)
pmud[1226]: timeleft = -1
pmud[1226]: initiating user requested sleep
			... I did not touch the iBook at all ...
pmud[1226]: polling adb for trackpad
pmud[1226]: found a trackpad (id = 3)
pmud[1226]: trackpad settings tap drag lock
pmud[1226]: calling sync()
pmud[1226]: running /etc/power/pwrctl sleep ac
pmud[1226]: going to sleep
pmud[1226]: system awake again
pmud[1226]: requested settings tap drag lock
pmud[1226]: trackpad settings tap drag lock
pmud[1226]: running /etc/power/pwrctl wakeup ac

May I need to add additional debug output ?

klaus.halfmann@t-online.de, 		(49)-(0)-6172/492497
Klaus Halfmann, Mainstrasse 8, 61352 Bad Homburg GERMANY

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
