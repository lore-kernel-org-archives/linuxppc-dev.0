In-Reply-To: <20000329155834.A30559@suse.de>
Date: Wed, 29 Mar 2000 18:50:16 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LinuxPPC and Pismo Powerbook
Message-Id: <20000329185016.026926@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, 2000, Olaf Hering <olh@suse.de> wrote:

>I have the Finder from MiBoot.smi, I changed the type/creator to
>FNDR/MACS. The System is the same from MiBoot, unchanged. There is a
>faked RomFile = yaboot and its .conf. Thats all.
>
>You have to move the Finder file out of that folder and move it back
>onto the closed folder icon and it is bootable. All you have to do now
>is to open the control panel Startup volume and you are done.
>
>I don't see the problem. What we really need is an app that creates the
>os-chooser file, what we need is the partition number and the path to a
>bootable SCSI device. I could do that from the Linux side via a bootable
>CD, but it would be nice to do it with a Mac application.

The good news is that I have the algorithm for writing to NVRAM on new
machines. That means that I'll be able to make a version of nvsetenv (or
nvtool) that works on all supported macs, probably this week-end.

There's still the problem of figuring out the correct OF path however.
Note that in my latest trees (and in bk 2.3.x), I've changed ide-pmac.c
to set it's own interface type so that /proc returns "mac-io" instead of
generic IDE. This should help differenciate the mac-io built-in IDE and
the CMD646 on B&W G3.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
