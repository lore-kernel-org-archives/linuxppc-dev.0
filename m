Date: Thu, 27 Feb 2003 09:27:01 -0700
From: Matt Porter <porter@cox.net>
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RFC: gt64260 descriptor struct
Message-ID: <20030227092701.A15982@home.com>
References: <200302271031.27317.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200302271031.27317.waite@skycomputers.com>; from waite@skycomputers.com on Thu, Feb 27, 2003 at 10:31:27AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 27, 2003 at 10:31:27AM -0500, Brian Waite wrote:
> What we need is a global structure for gt code that will describe the features
> of the gt and export that to drivers that need it. What I see right now for
> required elements are:

All peripherals that don't have intelligent discovery mechanisms could
make use of the OCP layer that 4xx uses.  gt64260, mpc10x, etc could
easily follow this same model that provides a standard device info.
discovery interface.  Of course, the OCP stuff in 2_4_devel is due
to be changed to match that of 2.5 is the near future...benh is
working on that.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
