Date: Sun, 27 Aug 2000 18:28:29 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com.au
Subject: Re: Patches for 2.4.0-test7
In-Reply-To: <39A8379C.E4EBB33A@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10008271823320.3745-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > AFAIK, CONFIG_ADBMOUSE cannot be selected without CONFIG_ADB_KEYBOARD in
> > the current bk tree. I'm also doing additional config fixes, so that ADB-
> > less pmacs can remove all the ADB stuffs and keep the PMU for example.
> > CONFIG_ADB_KEYBOARD is not displayed when CONFIG_INPUT_ADBHID is, etc...
>
> Someone recently wrote that one could have both /dev/adbmouse and
> /dev/input/mice working at the same time, so I tried this, too. And I
> *could* select CONFIG_ADBMOUSE without CONFIG_ADB_KEYBOARD, only it
> didn't compile due to undefined variables. My patch fixes these, but
> indeed it is probably better to change the config.in files to forbid
> this choice.

That would have been me - I still claim that keeping adbmouse working for
backwards compatibility would be a good thing, but my word doesn't carry
much weight.

The adbmouse driver only relies on the keyboard driver for mouse button
emulation. At least in 2.2.17, it won't interfere with the new input code,
I haven't tried 2.4.0 yet.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
