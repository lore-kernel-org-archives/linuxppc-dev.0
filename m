Message-ID: <38351D54.34124FBD@switchboard.ericsson.se>
Date: Fri, 19 Nov 1999 10:50:12 +0100
From: Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>
Reply-To: ken@kieraypc01.p.y.ki.era.ericsson.se
MIME-Version: 1.0
To: Jim Chapman <jim.chapman@iname.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: configuring swap on a diskless mpc860 embedded target
References: <38340F9F.E7A9CC63@iname.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A question:
    Have you ever swapped over nfs on any linux system?  I don't think it
works.

The only way I know of is using the network block device and a patch to make
swapping over that work.


Jim Chapman wrote:

> Is anyone using an NFS-mounted swap file on an mpc860 diskless system?
>
> I created a swap file on the embedded target using
>
> dd if=/dev/zero of=/SWAPFILE bs=1k count=8192
> mkswap /SWAPFILE
>
> But when I try to enable swapping using "swapon /SWAPFILE", linux
> complains that it can't find a swap signature in the file. I've looked


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
