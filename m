Message-Id: <v03110700b4ed3e1295ce@[129.100.29.243]>
In-Reply-To: <200003091632.IAA29278@berkeley.innomedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 9 Mar 2000 06:44:06 -0500
To: Michael Thompson <mickey@berkeley.innomedia.com>,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: IDE problems with 2.3.49?- same with 2.2.15pre3
Cc: mickey@berkeley.innomedia.com (Michael Thompson)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just finished installing linuxppc 2000 on my brand new G4 450MHz box and
every time I try to boot into my linux side with Bootx 1.2fc1 I get the
exact same error messages:

hdc: lost interrupt
hdd: lost interrupt

and on top of that

usbcore: USB device not responding, giving up (error=-101).

The funny thing is that the installation from the ramdisk went fine and the
keyboard and things worked with no problem.

I have tried the hda=noautotune .. hdb= ... hdc= to no avail.

Is there something different about recent G4 450s that I need to worry about?

Thanks,

Kevin


At 08:32 -0800 3/9/00, Michael Thompson wrote:
>I've been trying to get version 2.3.49 booted on my B&W G3 (USB/IDE).
>
>It can probe the IDE drives, and they spin up, but it isn't getting
>interrupts from IDE0:
>
>	hda: lost interrupt
>	hda: lost interrupt
>		.
>		.
>	hdb: lost interrupt
>	hdb: lost interrupt
>
>I have been able to boot with a ram disk, and the keyboard works,
>so interrupts, in general, are working.
>
>At this point, the problem seems to be isolated to IDE.
>Has anyone had success with this?
>
>Btw, I got the kernel from fsmlabs' web-site. It's rtlinux v3 pre 4.
>
>Thanks,
>
>Michael Thompson
>mickey@berkeley.innomedia.com
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
