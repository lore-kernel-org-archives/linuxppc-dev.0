Date: Tue, 1 Oct 2002 22:25:12 -0500
From: Michael Heironimus <mkh01@earthlink.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Location for Linux kernel module support files
Message-ID: <20021002032512.GA4094@demonspawn.sterno.shacknet.nu>
References: <5.1.0.14.2.20021001100707.02dbfb50@mail.attbi.com> <3D99F21B.5090408@mrsl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D99F21B.5090408@mrsl.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 01, 2002 at 03:06:03PM -0400, Tim Moloney wrote:
> Perhaps there is no good answer to this.  I thought that this situation
> happened enough that people had found a reasonable location for support
> files.

Support files required at boot time should probably go somewhere under
/etc or /lib, since those are more or less guaranteed to be mounted.
Other common locations for support files are /usr/lib or /usr/share, but
for something running at boot you may be faced with /usr not being
mounted yet.

--
Michael Heironimus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
