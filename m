In-Reply-To: <Pine.LNX.4.10.9911171932360.868-100000@PetesBox.localdomain>
Date: Thu, 18 Nov 1999 11:04:11 +0100
To: phandel@cise.ufl.edu, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Extreme swapping / new location of Paul's kernels [was Re: Kernel debugging??]
Message-Id: <19991118110411.015070@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999,  <phandel@cise.ufl.edu> wrote:

>I've noticed the same extreme swapping in 2.3.26, using SCSI disks
>(PowerCenter Pro 210) and BootX.  Returning to my previous kernel, there
>was no swapping. This was using BootX 1.2b1.

And I have absolutely no idea about what in BootX can cause this. Could
you check if the amount of available RAM seen by the kenrel is correct ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
