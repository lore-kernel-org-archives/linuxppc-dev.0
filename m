Message-ID: <002801c39153$f76fd3c0$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <001d01c39133$20f088a0$2803050a@JackyLam> <5.1.0.14.2.20031012203903.02e546d8@mail.ebshome.net>
Subject: Re: Walnut PCI bridge can't be detected
Date: Mon, 13 Oct 2003 14:33:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Also, according to the log you posted bus enumeration was successful and
> your device (es1371) was found. So I don't think you have a problem with a
> bridge.
>
> FYI, bridge is not responsible for delivering IRQs from your card. IRQ
> lines from the PCI slots are directly wired to the UIC (see
> walnut::ppc405_map_irq for actual mapping).

    Yes, I know. Let me clarify my question again...Sorry for my blur
question.
    What I mean is:
        Will there some miss configuration of bridge which will affect the
behavior of PCI cards/slots?

>
> According to your log you have inserted card into the PCI slot 1, is this
> correct ?
>
> If you still suspect that you have bridge problem, just insert some other
> PCI card which is know to be supported by PPC kernel and see...

    Yes. Is there a list of popular PCI cards which are supported by PPC
kernel directly without need of any modifications?

    Thanks.

Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
