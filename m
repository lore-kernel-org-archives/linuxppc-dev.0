Subject: Re: [PATCH 2.6] LongTrail W83C553 IDE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0401181317170.653@callisto>
References: <Pine.LNX.4.58.0401181317170.653@callisto>
Content-Type: text/plain
Message-Id: <1074468485.814.35.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:28:05 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 23:22, Geert Uytterhoeven wrote:
> The patch below enables the W83C553 IDE interface on the CHRP LongTrail.
> It's a straight forward port of the W83C553 fixup code for LongTrail and Briq
> in 2.4.x. It was tested on LongTrail only, using a ST340810ACE hard drive.
> Briq support may need additional changes.
>
> The patch is relative to 2.6.0 in the linuxppc-2.5 tree on December 22.
> Please apply, thanks!

I will take care of it along with the briq stuff, thanks.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
