MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: NFS with FEC problems - Hardhat 1.2 target file system
Date: Mon, 13 Aug 2001 12:03:32 -0500
Message-ID: <3A494DE356A49A40B37442E1E0D9F3B5063416@ptah.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have the 2.4 kernel (Hardhat 1.2) from MVista running on my custom
board. When I NFS mount the sample target file system from the Hardhat
1.1 version, everything works just fine. Now, when I try and mount the
new sample target file system that comes with the Hardhat 1.2 version,
the file system is mounted. But after all the init scripts are run, I
get messages like

'nfs server x.x.x.x not responding'

I have an FEC driver running on my custom board. I was able to duplicate
the problem with FEC running on the RPXClassic board. With SCC driver
selected on the RPXClassic, there are NO such problems.

Something executed during the init scripts is messing up the FEC .......
But I am not exactly sure what and where the problem lies.

I am able to get rid of the problem by replacing the inittab file and
not doing most of the initialization that the new target file system
inittab does. But I would like to know the real cause of this behaviour.

Any suggestions or input?

Thanks a lot.
Navin.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
