Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8260 w/256MB RAM problem
Date: Mon, 9 Sep 2002 20:32:40 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEOHDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have an 8260 base board with 256MB of RAM. If I tell the system that there
is 256MB it boots, sort of, but /proc only contains "mounts". (Note: I have
been running this as if there was 128MB-0x08000000 til this point) If I tell
the system that there is something less than 256MB, for instance 0x0C000000
of RAM, the system boots and works fine. Could it be trying to use an extra
BAT?

Any ideas?

Note: This is based on the EST8260 embedded boot which passes in a bd_info
structure that contains the memory size.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
