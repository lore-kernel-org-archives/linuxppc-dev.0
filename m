From: phandel@cise.ufl.edu
Date: Sun, 7 May 2000 20:04:22 -0400 (EDT)
To: Alain Birtz <abz@videotron.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to set on/off the keyboard led ?
In-Reply-To: <3915EA53.F863A6C9@videotron.ca>
Message-ID: <Pine.LNX.4.21.0005072001590.12656-100000@adsl-78-160-189.gnv.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 7 May 2000, Alain Birtz wrote:

> Where can I get info to set on/off the keyboard led (usb)?

Take a look at ifled, which uses the keyboard LEDs to indicate network
send/receive activity.  Works well with LinuxPPC, and the source code is
very straightforward.

http://www.sudac.org/~napolium/linux/ifled/ifled-0.6.tar.gz


Thanks,
Peter

GCS d+ s+: a-- C++ UL+++ L+++ M++ PS-- PE++ Y+ PGP+ t+ X+ tv-- b+ e++>+++ y-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
