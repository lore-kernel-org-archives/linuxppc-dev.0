Date: Wed, 29 Mar 2000 15:58:34 +0200
From: Olaf Hering <olh@suse.de>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329155834.A30559@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <Pine.GSO.4.05.10003281041030.24048-100000@grad> <38E1AAC1.A8999A9B@ncal.verio.com> <20000329043355.A27338@plato.localdomain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000329043355.A27338@plato.localdomain.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, Ethan Benson wrote:

> On Tue, Mar 28, 2000 at 11:03:29PM -0800, Henry Worth wrote:
>
> > > * STEPS :
> > > 1.  partitioned the HD into three partititions: MacOS, Linux, Swap
> >
> > I'd strongly recommend a small HFS boot partition (~32MB).
>
> 32MB??  lord no, 800K is more then enough for yaboot.

What about different kernel images? 32 MB is a good value.
And it is more secure, even for older Macs with BootX.
I don't trust the hfs.o

> this partition should also be given a partition type of
> Apple_Bootstrap to prevent Macos from mounting, and subsquently
> screwing it up.  (it removes the `blessing' from anything that might
> not be a valid macos system folder)

There is nothing on that partition that can be screwed up and the user
can change the yaboot.conf and the os-chooser file from the MacOS side.

I had never problems with my faked system folder, I move it around, to
CDs, to netatalk servers and where ever I want. This can be a "feature"
of OS9 that it doesn't remove the information, I don't know.

What makes this blessing so special??

I have the Finder from MiBoot.smi, I changed the type/creator to
FNDR/MACS. The System is the same from MiBoot, unchanged. There is a
faked RomFile = yaboot and its .conf. Thats all.

You have to move the Finder file out of that folder and move it back
onto the closed folder icon and it is bootable. All you have to do now
is to open the control panel Startup volume and you are done.

I don't see the problem. What we really need is an app that creates the
os-chooser file, what we need is the partition number and the path to a
bootable SCSI device. I could do that from the Linux side via a bootable
CD, but it would be nice to do it with a Mac application.

Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
