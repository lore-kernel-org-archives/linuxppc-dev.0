Subject: Re: Need testers: G3 @ G4 laptops (powerbooks & ibooks)
From: digger vermont <dv_mlist@verizon.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1077074495.1082.94.camel@gaston>
References: <1077074495.1082.94.camel@gaston>
Content-Type: text/plain
Message-Id: <1077125211.6437.5.camel@myrna>
Mime-Version: 1.0
Date: Wed, 18 Feb 2004 12:58:05 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On Tue, 2004-02-17 at 22:21, Benjamin Herrenschmidt wrote:
> Hi need people who own those machiens, especially the recent iBook2 models
> with a G3 CPU and titanium powerbooks with a G4, to test this patch and
> tell me if sleep mode still works reliably or becomes unstable.
>
> (It won't help machines that cannot already sleep).
>
> Applies on top of current 2.6 but may apply to 2.4 as well..

It seems okay here.

Linux myrna 2.6.3-rc3-ben1 #3 Wed Feb 18 11:28:22 EST 2004 ppc GNU/Linux

processor       : 0
cpu             : 7455, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 665.60
machine         : PowerBook3,4
motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
detected as     : 73 (PowerBook Titanium III)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld


Thanks.

digger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
