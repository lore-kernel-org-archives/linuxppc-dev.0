From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Masik <masik@pc203b.fzu.cz>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Occasional crash reports
Date: Tue, 14 Aug 2001 18:28:27 +0200
Message-Id: <20010814162827.16595@smtp.adsl.oleane.com>
In-Reply-To: <4vg0auiq9k.fsf@darbujan.fzu.cz>
References: <4vg0auiq9k.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi,
>
>I haven't observed any problem with recent kernels from your tree with
>power supply. When running on battery kernel crashes soon (usually by
>15 minutes). This is on my Pismo (March 2000) with 2.4.7-ben0. On the
>second thought it might be related to USB as well as I'm not using
>battery and USB mouse uncorrelated - IIRC one crash occurred inside
>hc_interrupt. I'll rsync and see what's the current status.

Make sure you have the latest yaboot (1.2.3), and add an initrd=<path>
line to your yaboot.conf in order to load the kernel's System.map along
with the kernel image. Also, enable xmon in your kernel. This will give
you some symbols lookup in xmon backtrace which is cool :)

If that crash ever happens again, send me the backtrace (or just copy me
PC, LR and the backtrace values and send along System.map)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
