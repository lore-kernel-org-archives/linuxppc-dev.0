From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Michel Dänzer <daenzerm@student.ethz.ch>
CC: Iain Sandoe <iain@sandoe.co.uk>, takashi oe <toe@unlserve.unl.edu>,
        linuxppc-dev@lists.linuxppc.org
Date: Mon, 31 Jul 2000 11:05:26 +0100
Message-ID: <yam8247.1300.146578880@mail.lf-online.de>
In-Reply-To: <39853D27.8F4F5500@relog.ch>
Subject: Re: LinuxPPC X Server
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 31-Jul-00 schrieb Michel Dänzer:

>Steffen Haeuser wrote:

Hi!

>agpgart was required _for r128 DRI_ until some time ago. It's possible that
>it's still needed by the driver in X 4.0.1 but definitely not in the latest
>DRI CVS.

That is really good news :) If anyone had the chance to try it out, please
tell so...
if this works, we might even take some of you guys into the Sin Beta Tester
programs,
if I remember right, we still need a handful of testers (but I have to check
with
the guy doing the Betatester issues in our company...).

>It's for flushing write combining buffers AFAIR, thus I thought an mb()
should
>do on PPC.

Yeah, think you should be right here... :)

>> (Well, AFAIK it is not even confirmed if this AGPart thing works with PCI,
>> but AFAIK it was said that it "should").

>PCI is not AGP, thus I don't think agpgart can work on PCI. There's also PCI
>GART, but there isn't PPC support for it either yet.

Well, the author of AGPart was cited that he "thinks it should work on PCI
too".
I cannot comment further on it. But if DRI does not require it any longer,
anyways,
seems this is no longer an issue :)

>I doubt it would be as easy on Linux - much more complexity to deal with than
>on AmigaOS :)

Driver Coding normally has not that much to do with the OS... :)
The main work is to find out how this Chip works, and then duplicate the
functionality
of an API by using the Chip Registers (and some of those sometimes do things
in a
*really cruel way*... some years ago I had to do some stuff on the old Virge
chip...
this was nasty...) The difficult is usually the register setup... not the
interface
to the OS...

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
