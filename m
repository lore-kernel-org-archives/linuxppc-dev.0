From: Brian Waite <waite@skycomputers.com>
To: Matt Porter <porter@cox.net>
Subject: Re: RFC: gt64260 descriptor struct
Date: Thu, 27 Feb 2003 13:01:10 -0500
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
References: <200302271031.27317.waite@skycomputers.com> <20030227092701.A15982@home.com>
In-Reply-To: <20030227092701.A15982@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302271301.10667.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Do you have any good pointers besides code on the implementation? I am reading
the code now to figure out how to make it work. On first look I think it will
fit, but I am not sure. I definitely see it as solving a different problem to
what I am trying to solve. Maybe this is due to my naivety on the OCP modle,
but I need to pass through infomation from the FW that is not determinable by
code. MAC addresses, for example are not stored in the GT64260. Instead, they
are either passed on the commandline or passed via PPCBoot. The same goes
with bus speed, the bus speed cannot be determined by any registers on the
gt64260. I need to preserve certain peices of information for uppper level
drivers regardless of if I am using OCP or not. I hope I am missing some on
the details of OCP and I can overcome my problem by using the OCP layer, but
I am not sure yet. Any thoughts?

Thanks
Brian



On Thursday 27 February 2003 11:27 am, Matt Porter wrote:
> On Thu, Feb 27, 2003 at 10:31:27AM -0500, Brian Waite wrote:
> > What we need is a global structure for gt code that will describe the
> > features of the gt and export that to drivers that need it. What I see
> > right now for required elements are:
>
> All peripherals that don't have intelligent discovery mechanisms could
> make use of the OCP layer that 4xx uses.  gt64260, mpc10x, etc could
> easily follow this same model that provides a standard device info.
> discovery interface.  Of course, the OCP stuff in 2_4_devel is due
> to be changed to match that of 2.5 is the near future...benh is
> working on that.
>
> Regards,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
