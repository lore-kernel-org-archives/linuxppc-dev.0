Date: Thu, 7 Feb 2002 23:25:57 -0700
From: Val Henson <val@nmt.edu>
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Highmem on PPC?
Message-ID: <20020207232557.B22964@boardwalk>
References: <20020207144308.C19569@boardwalk> <Pine.LNX.4.33.0202080101000.9080-100000@blues.wcg.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0202080101000.9080-100000@blues.wcg.mcgill.ca>; from christopher.murtagh@mcgill.ca on Fri, Feb 08, 2002 at 01:05:23AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 08, 2002 at 01:05:23AM -0500, Christopher Murtagh wrote:
>
> On Thu, 7 Feb 2002, Val Henson wrote:
> >Also, I don't think this was a particularly good test of highmem since I
> >don't think many bounce buffers were used, or that the kernel had much
> >reason to map/unmap many highmem pages.  Unfortunately, my SCSI
> >controller isn't working quite right and I can't test with a hard disk
> >as a result.  Any ideas for stressing the system harder?
>
>  My Dual800 ran fine for well over a week in my office with 1GB of RAM and
> with SMP. It also ran with a load average of around 10 for a couple of
> hours when I tried to stress test it. It was only when it started getting
> a bit of network traffic after moving it into our machine room did it
> crash, and then it crashed often. (It was also compiled with GMAC and BMAC
> network drivers).
>
>  So, don't know if this info helps or not, but I'd say try giving it a
> network stress test as well as a heavy CPU load. Once I turned off SMP, it
> seems to be very stable (still with 1 GB of RAM).

Thanks for the suggestion, but I was doing all that work on an NFS
mounted root in addition to the two flood pings. :) I think the
network was being stressed quite well.

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
