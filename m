From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in
 dao mode
Date: Fri, 26 Jan 2001 12:07:24 +0100
Message-Id: <19341221043908.3227@mailhost.mipsys.com>
In-Reply-To: <20010125165015.B15827@allspice.cs.swarthmore.edu>
References: <20010125165015.B15827@allspice.cs.swarthmore.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have a Powermac 7500 (with a G3 accelerator.)  I have replaced the
>internal CD-ROM with a Yamaha CD-RW drive.  This sits on the mesh SCSI
>bus.  I have the mesh driver configured to run at 5 megabytes/second
>(since I get massive SCSI problems all over the place if I set it to
>10.)  Under a variety of kernels, from 2.2.15 or so to 2.4.0 from Paul
>Mackeras's tree, my SCSI setup is generally stable and I can burn CD-R
>disks just fine in track-at-once mode.  However, if I try to burn a disk
>in disk-at-once mode, either with cdrdao or cdrecord, the SCSI bus
>appears to silently lock up hard, bringing down my whole machine.
>Nothing is logged at all, as far as I can tell.  Has anyone had this
>problem before?  Does anyone know of a solution?  If not, how would I go
>about debugging this further?

Do you see any kind of kernel error messages on the console before it
locks up ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
