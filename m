Subject: Re: Why is the Powerbook Fn-Key handled differently?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Matthias Grimm <joker@cymes.de>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3C5ED0F9.5060908@cymes.de>
References: <3C5ED0F9.5060908@cymes.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: 05 Feb 2002 11:03:43 +0100
Message-Id: <1012903423.1594.533.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-02-04 at 19:20, Matthias Grimm wrote:

> I own an Powerbook G3 which has a Fn-Key for his special functions.
> During my kernel source studies I learned that there are two keyboard
> drivers: 1. The old machintosh keyboard driver and
>           2. The new event driven Human Input Device from Vojtech Pavlik
>
> The old driver map the scancode for the Fn-Key to a different value and
> passes it to the Kernel keyboard driver. The new HID filters the Fn-Key
> completely out, as the attached code fragments below show.
>
> Is there any reason to cut out the Fn-Key in the new input driver?
> Nevertheless the Fn-Key is hard wired with the special keys and the
> number block, it would helpful to have an additional qualifier key on
> this small keyboard.

If the fn key generates a keycode, existing shortcuts involving it won't
work anymore, will they? I'm specifically thinking of stuff like
ctrl-alt-{+,-} to switch resolutions in X.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
