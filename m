From: tom_gall@vnet.ibm.com
Message-ID: <390F42CB.11AAF8D@vnet.ibm.com>
Date: Tue, 02 May 2000 21:04:11 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Display Adapters / i386 interpreter
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

  You'll excuse the very strange question I have and maybe this isn't
quite the right spot so feel free to correct me but here goes!

  On various display adapters alot of them have their own "BIOS" which
is executed to init the card. These tend to be written as an i386 kind
of thing. Well obviously on IA32 this isn't a big deal but how does
PowerPC hardware deal with these kinds of cards? Or doesn't it?

  Is there an IA32 interpreter of sorts that can run the small amount of
BIOS to bring up the card? Or is the approach different?

  Thanks much! I'd sure appreciate it, I'm doing some scouting of the
possibility of getting more / better card support of LinuxPPC on RS6000
hardware. Not being too familiar with this kinda issue I thought I'd
turn to the great global brain for help.

http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
