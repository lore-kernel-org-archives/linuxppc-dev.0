In-Reply-To: <v03110700b4ed3e1295ce@[129.100.29.243]>
Date: Thu, 9 Mar 2000 20:17:38 +0100
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
Message-Id: <20000309201738.011546@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 9, 2000, Kevin B. Hendricks <khendricks@ivey.uwo.ca> wrote:

>I just finished installing linuxppc 2000 on my brand new G4 450MHz box and
>every time I try to boot into my linux side with Bootx 1.2fc1 I get the
>exact same error messages:
>
>hdc: lost interrupt
>hdd: lost interrupt
>
>and on top of that
>
>usbcore: USB device not responding, giving up (error=-101).
>
>The funny thing is that the installation from the ramdisk went fine and the
>keyboard and things worked with no problem.
>
>I have tried the hda=noautotune .. hdb= ... hdc= to no avail.
>
>Is there something different about recent G4 450s that I need to worry about?

Use yaboot, not BootX and tell me if you still have the problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
