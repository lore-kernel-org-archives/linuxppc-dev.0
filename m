Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: question: "disabling IRQ 54 defensively?"
Date: Sun, 17 Feb 2002 15:38:16 -0500
References: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca> <p05101401b895b9cbee49@[10.0.0.42]>
In-Reply-To: <p05101401b895b9cbee49@[10.0.0.42]>
MIME-Version: 1.0
Message-Id: <20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just finished installing the ATA-100 card with two master IDE drives
(each on its own ribbon cable).

Now when I boot I see 7 to 10 lines that all say:

"disabling IRQ 54 defensively"

Later on I see the following:

ide0 "blah" on irq 19
ide1 "blah" on irq 20
ide2 0x440-0x447, 0x432 on irq 54
ide3 0x420-0x427, 0x412 on irq 54

Should I be worried here?  What does the disabling IRQ 54 defensively mean?

Is it wrong to have two ide devices with the ssame irq?  Are they just
sharing it?

Any info would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
