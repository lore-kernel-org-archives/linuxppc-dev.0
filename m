Message-Id: <200007251835.TAA17687@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 19:35:36 +0100
Subject: Re: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Steffen,

On Tue, Jul 25, 2000, Steffen Haeuser wrote:
> Am 25-Jul-00 schrieb Iain Sandoe:
[...]
>>I did a back-port of the 2.4.0-test4 dmasound stuff to 2.2.17pre10-ben2
>>(will check on pre13-ben1 later):
>>http://www.drfruitcake.com/linux/linuxppc.html
>
> I guess the dmasnd-v2a.patch is the file to get ? Hmmm, is there also a Binary
> Version available somewhere ? I do not have the latest Kernel Source on my
> machine
> and would like to avoid having to download it if possible...

OK I've done a build - hope it's got enough in it to boot your machine :-)
it's linked to the page given above along with the modules & system map.

=====

To find the sound chip info (on my machine) under linux:

cat /proc/device-tree/pci/mac-io/davbus/sound/compatible

of course, different machines have different IO structures so YMMV...

a bit of poking around under proc should reveal something sensible (it's not
that big a tree really)...

Tschuss,

Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
