From: "Ole Andreas Torvmark" <ole.torvmark@radionor.no>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Compiling linux-2.4.devel on a sandpoint
Date: Wed, 14 Nov 2001 15:00:50 +0100
Message-ID: <MHEAIGEFFBAFIOMKCIGCOEKDCAAA.ole.torvmark@radionor.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi !

So now i'm down to just this problem during last stage of linking on my
Sandpoint board:

fs/fs.o: In function `cpuinfo_open':
fs/fs.o(.text+0x2453a): undefined reference to `cpuinfo_op'
fs/fs.o(.text+0x2453e): undefined reference to `cpuinfo_op'






Tom Rini wrote :

>>  fs/fs.o: In function `cpuinfo_open':
>>  fs/fs.o(.text+0x2453a): undefined reference to `cpuinfo_op'
>>  fs/fs.o(.text+0x2453e): undefined reference to `cpuinfo_op'

>Sandpoint needs to be updated to the new cpuinfo stuff.


I'm quite new to the linux kernel so I don't think I can fix this, but has
someone allready done this perhaps ?

Just wondering when this update will be done or if anybody can point me in
the direction of a working source for an older 2.4.devel kernel for the
Motorola Sandpoint card.



Regards
Ole Andreas Torvmark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
