MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16394.63877.394603.88313@cargo.ozlabs.ibm.com>
Date: Mon, 19 Jan 2004 08:24:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.6] LongTrail W83C553 IDE
In-Reply-To: <Pine.LNX.4.58.0401181317170.653@callisto>
References: <Pine.LNX.4.58.0401181317170.653@callisto>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

> The patch below enables the W83C553 IDE interface on the CHRP LongTrail.
> It's a straight forward port of the W83C553 fixup code for LongTrail and Briq
> in 2.4.x. It was tested on LongTrail only, using a ST340810ACE hard drive.
> Briq support may need additional changes.

Can we figure out a way to do this without so many #ifdefs, please?

Thanks,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
