Date: Thu, 29 Mar 2001 01:43:41 -0500 (EST)
From: Daniel Berlin <dan@www.cgsoftware.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davem@redhat.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <Pine.LNX.4.05.10103290815070.11053-120000@callisto.of.borg>
Message-ID: <Pine.LNX.4.10.10103290139551.18522-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave, I already took care of most of these. If you remove the selfid
bitfields, the set of patches i sent to the linux1394 list recently to
make it work on a powerbook g3 should work fine on other big-endian
architectures.

I also have a set of endian fixes for the sbp-2 driver that james goodwin
(author of the sbp-2 stuff) is working on integrating, mainly it involves
removal of all of the bitfields, which were screwing up non-LE
architectures.

I happily use my two 45 gig firewire drives under LinuxPPC, and have been
for weeks.

--Dan
 On Thu, 29 Mar
2001, Geert Uytterhoeven wrote:

> FYI...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
