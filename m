Date: Wed, 2 Aug 2000 10:14:57 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Donald Cowart <dcowart@acld.lib.fl.us>
cc: tom_gall@vnet.ibm.com, bob@kunk.jriver.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: RS/6000 Model 170 Boots Linux
In-Reply-To: <Pine.LNX.4.20.0007311238420.16971-100000@bookworm.acld.lib.fl.us>
Message-ID: <Pine.HPX.4.10.10008020957080.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jul 2000, Donald Cowart wrote:

>
> What are the 604e PowerPC chips, 32bit or 64bit?

32 bit. Call me the day an affordable 64 bit machine is available (I mean
for home user/hobbyist). No Apple machine has ever had a 64 bit processor
to start with.

Note that actually running the kernel in 32 bit mode makes sense
on 64 bit processors since the code is smaller (building addresses is much
easier and does not require a TOC) and there are fairly simple and cheap
MMU tricks to access all memory if needed (playing with segments but this
can be kept local to a given CPU, so no locking is necessary).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
