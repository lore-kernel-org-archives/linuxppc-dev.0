Date: Thu, 25 Jan 2001 16:50:15 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010125165015.B15827@allspice.cs.swarthmore.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I asked this in linuxppc-user bothj yesterday and months ago, and have
not received any replies, which made me wonder if this list would be a
better place to ask.  I haven't done any significant kernel hacking, but
know C well and am more than happy to try to debug and see if I can fix
this, but I'm not sure where to start.  I guess the first thing to do
should be to boot from a disk on the other SCSI bus and see what errors
I get from mesh, since right now everything just freezes hard without
any visible diagnostics.  Or is there a way, even with a totally frozen
SCSI bus (containing the swap partition among other things, though I can
of course swapoff before testing this) to tell anything useful about the
state of the machine once SCSI is frozen.  I have vaguely heard of, but
don't know the details of this "magic sysrq" thing.  Would that be
useful?

Please excuse my cluelessness -- any advice that people have is much
appreciated!

The text of my original message with the details of the problem is
below.

Thanks,
Daniel Eisenbud

----- Forwarded message from Daniel Eisenbud <eisenbud@cs.swarthmore.edu> -----

Date: Wed, 24 Jan 2001 22:28:54 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: linuxppc-user@lists.linuxppc.org
Subject: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode


I have a Powermac 7500 (with a G3 accelerator.)  I have replaced the
internal CD-ROM with a Yamaha CD-RW drive.  This sits on the mesh SCSI
bus.  I have the mesh driver configured to run at 5 megabytes/second
(since I get massive SCSI problems all over the place if I set it to
10.)  Under a variety of kernels, from 2.2.15 or so to 2.4.0 from Paul
Mackeras's tree, my SCSI setup is generally stable and I can burn CD-R
disks just fine in track-at-once mode.  However, if I try to burn a disk
in disk-at-once mode, either with cdrdao or cdrecord, the SCSI bus
appears to silently lock up hard, bringing down my whole machine.
Nothing is logged at all, as far as I can tell.  Has anyone had this
problem before?  Does anyone know of a solution?  If not, how would I go
about debugging this further?

Thanks in advance,
Daniel Eisenbud

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu




----- End forwarded message -----

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
