Date: Thu, 28 Sep 2000 20:14:47 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <B5F8C52A.65D%jween@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10009282012560.3421-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I tried the changes you suggested, no difference. (I couldn't figure out
> what you meant by "layout at the end.", was there more to the email that
> didn't get through?)

I meant move the first section (server layout IIRC) to the end of the
file. Nothing complicated.

> But, honestly, I can't see why these changes should influence whether or not
> the Xserver detects the video device. That seems to be the main problem.
> It's looking for a particular device at a particular memory address
> (presumably specified by the "ati" driver file) and is not finding it. I

Neither do I, and it works perfectly for me ...

I can send you my config if nothing else helps.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
