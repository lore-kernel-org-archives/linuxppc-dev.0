Date: Thu, 19 Jun 2003 14:52:13 -0500 (CDT)
From: vinai <4_usenet@yahoo.com>
To: Debian PowerPC List <debian-powerpc@lists.debian.org>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: firewire issues with 2.4.21 from kernel.org ?
In-Reply-To: <20030617203311.76e5408a.billfink@mindspring.com>
Message-ID: <Pine.LNX.4.44.0306191446530.448-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just wanted to pass the info back to the various mailing lists.  The
advice Bill posted below worked, so I'm once again able to access my
firewire drive.  In Debian 3.0, the rescan-scsi-bus.sh script was in
the scsitools package.

Thank you again Bill.

cheers
vinai

On Tue, 17 Jun 2003, Bill Fink wrote:

> On Tue, 17 Jun 2003, vinai wrote:
>
> > Has anyone successfully used the latest kernel.org stable kernel with
> > firewire successfully ?? I use an external hard drive to be able to
> > take work with me, but with a 2.4.21 kernel, I get the message:
> >
> > /dev/sdc2 is not a valid block device
> >
> > While with 2.4.20 (also from kernel.org), it works perfectly. This is
> > on an 8500 using a PCI firewire card with a TI chipset, and running
> > stock Debian 3.0, except for the kernel upgrade.
>
> I believe that the sbp2 module in 2.4.21 now _requires_ you to run
> the rescan-scsi-bus.sh for _all_ FireWire devices, whereas the sbp2
> module that came with 2.4.20 didn't require that for any FireWire
> devices that were already powered on and attached at the time the
> sbp2 module was loaded.
>
> 						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
