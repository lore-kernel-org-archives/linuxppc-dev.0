From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Timothy A. Seufert" <tas@mindspring.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Date: Fri, 1 Sep 2000 13:02:21 +0200
Message-Id: <20000901110221.5823@mailhost.mipsys.com>
In-Reply-To: <v04220803b5d51a99c774@[10.0.0.42]>
References: <v04220803b5d51a99c774@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>1. Resource conflicts are reported for the CMD646 IDE controller and
>an Adaptec 2940UW card

Please, send me logs of dmesg, /proc/device-tree (with lsprop), and /
proc/pci.

>2. During the fb probe of the Rage 128 PCI card, a pattern of colored
>characters is written to the screen.  This might be somebody's
>deliberate debug output, as it almost looks too regular to be an
>error.

I noticed that too. It happens only occasionally. Sometimes, it's so bad
that I never get a single correct char displayed, sometimes it just
doesn't happen. Note that I didn't have the problem for a week or two
now, I thought it was fixed. Sounds a bit like someone is corrupting memory...

>3. When attempting to do the partition scan, the kernel has massive
>problems with lost IDE interrupts and failed DMA stuff.  Eventually
>it gives up and moves on without successfully scanning my IDE drive.

With the CMD controller ? The mac-io should work fine with the current
bk, the CMD still have problems.

>4. Probably due to the resource conflict problem, the aic7xxx driver
>doesn't recognize the 2940.  This is a showstopper for me because my
>
>root partition's on a drive connected to the 2940.

I'll see what I can do.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
