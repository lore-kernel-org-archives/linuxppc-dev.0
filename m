Date: Wed, 24 Oct 2001 15:12:55 -0700
From: Dan Cox <danc@mvista.com>
To: Iain Young <iain@g7iii.junglelink.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Motorola LOPEC 1U Board
Message-ID: <20011024151255.A11765@merlin.hawlab.org>
Reply-To: danc@mvista.com
References: <20011024200210.A774@g7iii.junglelink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20011024200210.A774@g7iii.junglelink.co.uk>; from iain@g7iii.junglelink.co.uk on Wed, Oct 24, 2001 at 12:02:10 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 2001.10.24 12:02 Iain Young wrote:
>
> Hi,
>
> I'm considering running Linux 2.4.x on the Motorola LOPEC 1U Board.
> Does anyone have any experience with this board ? Any hints or
> tips ? Or gotchas for that matter ?
>
>
> All the Best
>
> Iain
>
> PS: If anyone knows of someone selling these boards in the UK, I'd
> be really gratefull - I can find a few Motorola resellers, but
> none seem to offer the LOPEC board.
>
>
>

Iain

Yep.  A LoPEC port is in the 2.4 devel tree.

No real gotchas.  Although it's an ATX board, definitely use a 1U case, since
the PCI slot doesn't line up to the slots on regular PC cases (unless you
hacksaw
the back off).

It's a pretty neat board, actually.  With a supported framebuffer, you could
probably
even use it for a desktop box (USB, IDE/SCSI).

--
Dan Cox
MontaVista Software


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
