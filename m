Date: Tue, 6 Feb 2001 11:21:48 -0600
From: Takashi Oe <toe@unlserve.unl.edu>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH not found with 2.4.1 on 7500
Message-Id: <20010206112148.0c9b60d3.toe@unlserve.unl.edu>
In-Reply-To: <20010206173709.A17234@suse.de>
References: <20010206173709.A17234@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Feb 2001 17:37:09 +0100, Olaf Hering <olh@suse.de> wrote:

>
> Hi,
>
> the current 2.4.1 can not found the mesh scsi controller on my 7500/100.
> It doesnt work with bootx and boot fd:vmlinux.coff.
>
> Any ideas how to fix it?

As far as I can tell, your kernel is not getting that far.  Before MESH
message output, you should have something like:

SCSI subsystem driver Revision: 1.00

which is missing.  On my system, there is IDE related messages immediately
following the loop device message, and it's followed by (old) adb mouse
driver and PPP device message.  SCSI is after all of those.


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
