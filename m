Date: Tue, 19 Jan 1999 08:13:30 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Gary Thomas <gdt@linuxppc.org>
Cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Johnnie Peters <jpeters@phx.mcd.mot.com>,
        Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linuxppc-dev@lists.linuxppc.org,
        Michael Meissner <meissner@cygnus.com>, Dan Malek <dmalek@jlc.net>
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
Message-ID: <19990119081330.A10519@tiktok.cygnus.com>
References: <Pine.LNX.3.96.990118095335.18478B-100000@persephone.cs.nmt.edu> <XFMail.990119102730.gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.990119102730.gdt@linuxppc.org>; from Gary Thomas on Tue, Jan 19, 1999 at 10:27:30AM -0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 19, 1999 at 10:27:30AM -0000, Gary Thomas wrote:
> 
> On 18-Jan-99 Cort Dougan wrote:
> > Please ship that to me and I'll stick it in.
> > 
> > I like Garbriels bootloader and I think it may be worthwhile to make the
> > MBX/PReP bootloader break sometime soon.  A relocatable bootloader for
> > prep would solve a lot of problems.
> > 
> > }I'll try upgrading to 2.2.0p7 tonight and see how that works.
> > }
> 
> Attached are my changes to add [minimal] residual data to PreP booting.
> I've also had to make some minor compatability changes to get extended
> partitions to work with old disks.

I see you added changes to set the initial cmd config.  Is there any way we can
add a configure line when building the kernel, so I can build a kernel with
different data (ie, my disk is /dev/sda2 and not /dev/sdb2, etc.).  That way it
has a better chance of working if rebooted in the middle of the night due to
power failure.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
