From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	"Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Subject: Re: question: "disabling IRQ 54 defensively?"
Date: Sun, 17 Feb 2002 22:53:40 +0100
Message-Id: <20020217215340.10006@smtp.wanadoo.fr>
In-Reply-To: <20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
References: <20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Later on I see the following:
>
>ide0 "blah" on irq 19
>ide1 "blah" on irq 20
>ide2 0x440-0x447, 0x432 on irq 54
>ide3 0x420-0x427, 0x412 on irq 54
>
>Should I be worried here?  What does the disabling IRQ 54 defensively mean?
>
>Is it wrong to have two ide devices with the ssame irq?  Are they just
>sharing it?

They are just charing it, nothing wrong

>Any info would be greatly appreciated.

The message means that the IRQ was detected as beeing shared and so disabled
during IDE probe. This is normal behaviour and is done to avoid the machine
locking up under some cicumstances, for example with PCMCIA ATA cards that
share their interrupt with the cardbus controller.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
