Date: Fri, 12 Oct 2001 05:51:50 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian-powerpc <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Last call for testing: yaboot-1.3.4pre3
Message-ID: <20011012055150.B10713@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am going to take the resounding silence as an indication that there
are no problems with yaboot 1.3.4pre.

I plan to release 1.3.4 this weekend unless someone speaks up and
points out some problem.

pre3 is up now, one test i would like to see is netbooting by holding
down the `n' key on bootup of a PCI G4 (not G3), these machines appear
to netboot with dhcp rather then bootp and i want to know if yaboot
will parse the bootpath properly.

On Blue G3s when booting via the `n' key the bootpath ends up being
enet:bootp yaboot has to throw away the bootp part to work, what i
want to know is if dhcp versions of OF use something like enet:dhcp or
equivilent.

Simply booting yaboot via `n key' netboot will answer this question,
if its using something like enet:dhcp yaboot will fail to locate its
config file and print out the device path it tried, just send me that
error message.

http://master.penguinppc.org/projects/yaboot/1.3.4pre/

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
