Date: Mon, 6 Mar 2000 14:02:52 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch to fix imps2 emulation for usb mice in stable 2.2.X series
In-Reply-To: <00030618293200.03743@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10003061359220.25631-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > You remind me of another USB mouse issue I stumbled on with 2.2.15: I had
> > happily set up X to use the USB mouse as secondary mouse in the Xinput
> > section for some time, when suddenly 2.2.15 changed the USB mouse
> > behavior. All USB mouse clicks were doubled or tripled ...
>
> My fault, I'm sorry, it seemed like a good idea at the time... :-)
> That was before I knew how to tell XFree86 to use two mice.  I have
> changed the #ifdef now.  If someone really wants this they can change the
> ifdef or something.

Thank. Turns out my other idea about testing the mouse active count didn't
work out for some reason so changing the ifdef is the only solution right
now.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
