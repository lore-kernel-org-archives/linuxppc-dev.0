From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need testers with MESH SCSI
Date: Tue, 26 Dec 2000 19:26:43 +0100
Message-Id: <19341120115827.19132@192.168.1.2>
In-Reply-To: <Pine.LNX.4.05.10012231533220.12626-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10012231533220.12626-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Note that there can be other problems with the mesh as well: I remember
I once
>had some early 2.3.x kernels that could not init the mesh when cold-booted,
>only when warm-booted. So I had to boot an older kernel first each time I had
>powered down my box :-)

There were issues with powering up the MESH on some powerbooks that were
fixed some time ago, but maybe your issue is unrelated.

Looking at Darwin's MESH driver, they have a whole bunch of workarounds
for known issues (either with common device protocol errors, or MESH
internal races).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
