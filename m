Message-ID: <396DCBCB.A4A574C8@erols.com>
Date: Thu, 13 Jul 2000 10:01:47 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Taylor Holliday <wtholliday@ucdavis.edu>
CC: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree 4.0.1 dual head attempt
References: <396D1C7B.AA6864F5@ucdavis.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Taylor Holliday wrote:

> Hi all
>
> Attached is the latest XFree86.0.log as well as the XF86Config from my
> recent build (yesterday) of 4.0.1 with the drivers rsync'ed from
> penguinppc.org. Hey, at least it doesn't crash the machine (AGP G4, 2
> r128) :-). Any suggestions on what to do or where to start debugging?
>
> <snip>
> (==) Implicit Core Pointer: Buttons: 3
> (II) Keyboard "Implicit Core Keyboard" handled by legacy driver
> (II) XINPUT: Adding extended input device "Implicit Core Pointer" (type: MOUSE)
> Couldn't load XKB keymap, falling back to pre-XKB keymap
>
> Fatal server error:
> Caught signal 11.  Server aborting
>
> <snip>
>
>   ------------------------------------------------------------------------
> Section "ServerLayout"
>         Identifier     "DualHead"
>         Screen         "Screen0"
>         Screen         "Screen1" RightOf "Screen0"
> #       InputDevice    "Mouse0" "CorePointer"
> #       InputDevice    "Keyboard0" "CoreKeyboard"
> EndSection

<snip>

This may be a stupid question, but why have you commented out your input devices?

--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
