From: "Jon Erick Ween" <jween@som.llu.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Jon Erick Ween <jween@som.llu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre18 kernel panic on Lombard
Date: Thu, 9 Nov 2000 07:13:04 -0800
Message-ID: <77374543518.AAAEB2@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
>> I'm trying to get my usb ports to work on my Lombard. I have 2.2.8pre17
>> running OK but without USB or 3-button emulation working (in console or
X).
>> rsynced and compiled 2.2.18pre18 without problems but wind up in a
kernel
>> panic after loading the adb mouse handler and pty configuration (see
>> below). Is this a problem with the new input layer (I don't seem to have

>> /dev/input/) or a problem with the Lombard's usb ports?
>
>Neither. I use a self compiled 2.2.18 and there's no such problem. At the
>time where you see the panic, the kernel doesn't yet know about the root
>filesystem, and consequently doesn't know about /dev/input/ either. What
>sort of USB mouse are you using? Do you have both ADB mouse and USB HID
>support configured?


I have a logitech wheel mouse and configured in support for both adb (to
use the track pad) and usb hid. Curiously, the options for confugring the
mac input layer were not activated, only the "old driver" was available.
Did I miss some important previous step?

Jon


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
