Message-Id: <4.3.2.7.2.20000707230217.00c1e280@mail.munich.netsurf.de>
Date: Fri, 07 Jul 2000 23:07:04 +0200
To: "Robert Thompson" <rothomp3@vt.edu>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: 2.2.17pre9-ben1 and airport
Cc: <linuxppc-dev@lists.linuxppc.org>, <bh40@calva.net>
In-Reply-To: <002e01bfe854$c4019c40$1a6a1504@strayer.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 22:48 07.07.00, Robert Thompson wrote:

>Hi, I have an iBook SE with an airport card, so naturally I was quite
>excited at the prospect of being able to use 32bit color (finally!) under
>Linux, and the AirPort card as well. So, I downloaded the source from
>ppclinux.apple.com/~benh, and built a new kernel. First of all, the mach64
>stuff seems to work fine with Xpmac, but the XF68_FBDev that's installed on
>my Yellow Dog 1.2 machine just puts a weird line on the screen. Oh well, no
>biggie, since Xpmac is working. I haven't tried XF4 yet, either. Now, on to
>the problems...
>1.) The trackpad won't work at all anymore, but external USB mice work fine.
>I did make the prerequisite changes in /dev.

Did you change any config options from Ben's default in .config? Please
make sure you enabled the options described at the top
of  <http://homepages.munich.netsurf.de/Franz.Sirl/inputppc.html>.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
