From: "Jon Erick Ween" <jween@som.llu.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Jon Erick Ween <jween@som.llu.edu>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
Date: Thu, 28 Sep 2000 12:49:22 -0700
Message-ID: <7736FE93133A.AAA55EE@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> wrote:
>> I tried the changes you suggested, no difference. (I couldn't figure out

>> what you meant by "layout at the end.", was there more to the email that

>> didn't get through?)
>
>I meant move the first section (server layout IIRC) to the end of the
>file. Nothing complicated.

OK, I'll try this.

>> But, honestly, I can't see why these changes should influence whether or
not
>> the Xserver detects the video device. That seems to be the main problem.

>> It's looking for a particular device at a particular memory address
>> (presumably specified by the "ati" driver file) and is not finding it. I

>
>Neither do I, and it works perfectly for me ...
>
>I can send you my config if nothing else helps.

Well, I recompiled the server and reinstalled. Now it doesn't exit with an
error, it just hangs, requiring a hard reboot. Looking at the XFree86.0.log
file it seems to be hanging on the ati probe step, suggesting that it finds
the device finally. Previous lines inform of reassigning pci memory
overlaps, but there are no errors. Maybe if I tried your config file and
modified for my ati driver?

Jon


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
