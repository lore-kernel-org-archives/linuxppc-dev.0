From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: BootX 1.1.3 and Rev 2 B+W G3's ?
Date: Thu, 16 Sep 1999 10:32:20 -0400
Content-Type: text/plain
References: <19990915120329.005173@mailhost.mipsys.com>
MIME-Version: 1.0
Message-Id: <99091610364000.00409@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am having lots of problems with BootX 1.1.3 on my rev2 B+W G3.  BootX 1.1.1
app works fine but I have no sound support.

I upgraded to BootX 1.1.3 and added the extension and tried to boot.

The extension gives a type 11 error but throws me into linux anyway.  But if I
generate a couple of sounds (beeps) I get a complete kernel hang.  The kernel
is also very very unstable with a seg-fault as root causing a kernel panic.

None of this happens with BootX 1.1.1 (although I have no sound either).

This is with Paul's kernel 2.2.10 and on the Mac side, a very stock install.

Is anyone else seeing these problems.

Any help here would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
