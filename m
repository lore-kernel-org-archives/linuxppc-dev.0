Message-Id: <4.3.2.7.2.20000714135437.00c70470@mail.munich.netsurf.de>
Date: Fri, 14 Jul 2000 14:04:06 +0200
To: "Iain Sandoe" <iain@sandoe.co.uk>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: [ANN] DMA sound patches V2[2.217pre10-ben2 & 2.4.0-test4]
Cc: Linuxppc-dev@lists.linuxppc.org,
        Linux-audio-dev@ginette.musique.umontreal.ca
In-Reply-To: <200007132354.AAA20368@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 01:53 14.07.00, Iain Sandoe wrote:

>Hello all,
>
>I have posted a version 2 of the LinuxPPC dmasound back-port from
>V2.4.0-test4 to 2.2.17pre10-ben2.
>
>Patches against this and 2.4.0-test4 (to add a bit more info about record
>buffers on the AWACS) can be found on:
>
>http://www.drfruitcake.com/linux/linuxppc.html
>
>along with explanations etc.
>
>Basically, there is now a single code-base with KERNEL_VERSION()
>conditionals...
>
>There is also a temporary (I expect) patch there that will get sound working
>on G3 Minitower & desktops under 2.4.0-test4.  It is not especially
>elegant... but it will get you going again.
>
>Thanks to those who have tested so far - particularly Gwyn Judd.
>Also thanks to Ben H & Geert for putting up with my dumb questions...

Nice work, thanks. One comment on module loading though, there's an easy
way to configure sound with the help of /etc/conf.modules, put these lines
in there:

alias sound dmasound_awacs
#options dmasound_core <parameters>

Uncommenting the 2nd line enables passing parameters to dmasound_core. With
these settings, sound should be autoprobed on bootup of your machine.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
