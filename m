To: Gabriel Paubert <paubert@iram.es>
Cc: Christian Zankel <chris@mvista.com>, Cort Dougan <cort@fsmlabs.com>,
        linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <Pine.HPX.4.10.9911231703280.5120-100000@gra-ux1.iram.es>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 23 Nov 1999 17:52:25 +0100
In-Reply-To: Gabriel Paubert's message of "Tue, 23 Nov 1999 17:15:21 +0100 (MET)"
Message-ID: <kfypux15ewm.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> writes:

> > 2. It should be possible to setup the kernel so that the same kernel
> > runs on all those machine that it is setup for. Of course, the more
> > machines you add the more overhead you get.
> 
> I don't care very much for 6xx/7xx machines... Embedded may want the
> smallest footprint however.

Yes, the more code you can loose in embedded kernels the better.
But note that embedded does not necessarily imply 8xx/82xx/4xx.
There are embedded boards with 6xx/7xx processors too.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
