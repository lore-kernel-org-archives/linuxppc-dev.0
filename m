Date: Thu, 9 Nov 2000 20:34:29 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre18 kernel panic on Lombard
In-Reply-To: <77374543518.AAAEB2@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10011092032240.4683-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> below). Is this a problem with the new input layer (I don't seem to have
>
> >> /dev/input/) or a problem with the Lombard's usb ports?
> >
> >Neither. I use a self compiled 2.2.18 and there's no such problem. At the
> >time where you see the panic, the kernel doesn't yet know about the root
> >filesystem, and consequently doesn't know about /dev/input/ either. What
> >sort of USB mouse are you using? Do you have both ADB mouse and USB HID
> >support configured?
>
>
> I have a logitech wheel mouse and configured in support for both adb (to
> use the track pad) and usb hid. Curiously, the options for confugring the
> mac input layer were not activated, only the "old driver" was available.
> Did I miss some important previous step?

Where did you get the kernel source from? Alan's 2.2.18pre doesn't have
the input layer code AFAIK, but both the BenH and Paul sources do.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
