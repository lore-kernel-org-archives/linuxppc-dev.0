Message-ID: <B25E2E5A003CD311B61E00902778AF2A02637AD2@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Improving ramdisk uncompression time...
Date: Thu, 4 Oct 2001 01:54:43 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

My setup has rather large ramdisk 5MB as the ramdisk contains
firmware for other boards in the system. In total boot time of
about 60 seconds, close to 50% is spent in uncompressing the ramdisk.

Has anybody tried building ramdisk with bizp2, what other ideas
one might consider to "speed up" the boot time particularly uncompressing
the ramdisk...

/Subodh Nijsure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
