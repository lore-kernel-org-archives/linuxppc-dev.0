Message-Id: <5.0.0.19.2.20000907164805.01f19660@mail.munich.netsurf.de>
Date: Thu, 07 Sep 2000 17:03:34 +0200
To: Michel Dänzer <daenzerm@student.ethz.ch>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: newer xfree86 4.0.1 patches
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39B78FF2.C0E4AD10@student.ethz.ch>
References: <20000906213248.A3749@suse.de>
 <5.0.0.19.2.20000907142215.01e79ca0@mail.munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 14:54 07.09.00, Michel Dänzer wrote:

>Franz Sirl wrote:
>
> > On my TODO list, I still have to make chrp_setup.c and prep_setup.c use
> > machid_init_hw() and friends in machid.c.
>
>While you're at it, can you do apus_setup.c as well please?

Sure I can, but APUS doesn't use either ADB or PS2 keyboards, or? I'm not
quite sure about the following:

- does Apus have it's own keycodes? If not, do you currently use ADB or AT
keycodes?
- what's the keycode situation in XF3/4 for Apus?
- if your developer repository for 2.4 is different from BK linuxppc_2_3,
did you integrate your input layer drivers in your trees and plan to submit
them for 2.4?

If you want to keep the current state of affairs I can see in the
linuxppc_2_3 tree, there's not much point in using machid.c, AFAICS. On the
other hand, if you plan to integrate your input drivers into 2.4, it makes
perfect sense.

So, I need a little bit more background information first.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
