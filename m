Date: Wed, 18 Feb 2004 14:14:29 -0800
From: Ira Weiny <iweiny@acm.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
Message-Id: <20040218141429.0e4ef4e4.iweiny@acm.org>
In-Reply-To: <1077074495.1082.94.camel@gaston>
References: <1077074495.1082.94.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Feb 2004 14:21:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
> Hi need people who own those machiens, especially the recent iBook2 models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.
>
> (It won't help machines that cannot already sleep).
>
> Applies on top of current 2.6 but may apply to 2.4 as well..

I applied it to 2.4.23-pre5-ben0.  It failed on Chunk 3.

> cat /proc/cpuinfo
cpu             : 7410, altivec supported
temperature     : 16 C (uncalibrated)
clock           : 500MHz
revision        : 17.3 (pvr 800c 1103)
bogomips        : 995.32
machine         : PowerBook3,2
motherboard     : PowerBook3,2 MacRISC2 MacRISC Power Macintosh
board revision  : 00000001
detected as     : 71 (PowerBook Titanium)
pmac flags      : 0000000b
L2 cache        : 1024K unified
memory          : 512MB
pmac-generation : NewWorld


It seems to be working ok.  What is this supposed to fix?  I have, since going
to Yellow dog 3.0, had random sleep "crashes".  I have been trying to figure
out what caused them but they really did seem to be random.

>
> Thanks !
>
> Ben.
>

No, thank you, I for one would be lost without your kernel.

Thanks,
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
