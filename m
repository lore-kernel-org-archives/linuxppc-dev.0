Date: Thu, 28 Sep 2000 09:51:38 -0700
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
From: "Jon Erick Ween" <jween@som.llu.edu>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Olaf Hering <olh@suse.de>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5F8C52A.65D%jween@som.llu.edu>
In-Reply-To: <Pine.LNX.4.10.10009272119250.10201-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael

I tried the changes you suggested, no difference. (I couldn't figure out
what you meant by "layout at the end.", was there more to the email that
didn't get through?)

But, honestly, I can't see why these changes should influence whether or not
the Xserver detects the video device. That seems to be the main problem.
It's looking for a particular device at a particular memory address
(presumably specified by the "ati" driver file) and is not finding it. I
thought switching from BootX to yaboot would fix this, but it hasn't. (I
thought I recompiled everything under a yaboot startup, assuming this would
fix the device name and memory specifications in the finished driver, but
maybe not. I'll do this again in any case, just to be sure.)

Do you have any other suggestions?
--
Jon Erik Ween, MD

Cognitive and Cerebrovascular Neurology

Assistant Professor
Loma Linda University School of Medicine

Director, Stroke Program
Loma Linda University Medical Center

> From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
> Date: Wed, 27 Sep 2000 21:21:44 +0200 (CEST)
> To: Jon Erick Ween <jween@som.llu.edu>
> Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> , Olaf Hering
> <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
> Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
>
>> Here's a copy of my XF86Config file.
>
> Only differences I can see:
>
> I don't use HwCursor, and I use ShadowFB off in the device section.
>
> I use mode lines as returned by fbset -x in the monitor section.
>
> Plus I don't use the empty Files section (fontpath there at least).
>
> Order shouldn't matter I hope, otherwise try the layout at the end.
>
> Michael
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
