Date: Tue, 23 Nov 1999 18:01:57 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
cc: Christian Zankel <chris@mvista.com>, Cort Dougan <cort@fsmlabs.com>,
        linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <kfypux15ewm.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Message-ID: <Pine.HPX.4.10.9911231758050.5120-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 23 Nov 1999, Marcus Sundberg wrote:

> Gabriel Paubert <paubert@iram.es> writes:
> 
> > > 2. It should be possible to setup the kernel so that the same kernel
> > > runs on all those machine that it is setup for. Of course, the more
> > > machines you add the more overhead you get.
> > 
> > I don't care very much for 6xx/7xx machines... Embedded may want the
> > smallest footprint however.
> 
> Yes, the more code you can loose in embedded kernels the better.
> But note that embedded does not necessarily imply 8xx/82xx/4xx.
> There are embedded boards with 6xx/7xx processors too.

Yes, but often they have at least 8Mb of RAM (which was the minimal spec
for PreP). In this case a few more kB in the bootloader to make it more
generic do not hurt as long as you can make the run time kernel as small
as possible. Why not dynamically link the kernel to remove useless code,
for example have a kernel plus modules and link them selectively at boot
time depending on the network or SCSI chip, we are a far way from this
but it should be possible.

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
