Subject: Re: Kernel 2.4.21-ben2 does not boot on Rev 1 Xserve
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Atro.Tossavainen@Helsinki.FI
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200307071146.h67BkHj02191@kruuna.Helsinki.FI>
References: <200307071146.h67BkHj02191@kruuna.Helsinki.FI>
Content-Type: text/plain
Message-Id: <1057581605.11707.15.camel@gaston>
Mime-Version: 1.0
Date: 07 Jul 2003 14:40:05 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-07-07 at 13:46, Atro Tossavainen wrote:
> Hello,
>
> I tried to upgrade the kernel on our Xserve to 2.4.21-ben2 which I just
> downloaded from source.mvista.com with rsync.
>
> The bootup messages scroll by quite quickly, but if I'm not mistaken,
> the IDE driver announced the following:
>
> PDC20270: neither IDE port enabled (BIOS)
>
> and fails to boot because it can't see the disks.

Did you enable CONFIG_PDC202XX_FORCE ? (Also called
"Special FastTrack Feature"). This option is needed for the Promise
controller on the Xserve motherboard.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
