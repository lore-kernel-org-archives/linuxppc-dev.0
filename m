From: Paul Mackerras <paulus@linuxcare.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Kevin Hendricks <khendricks@ivey.uwo.ca>
Subject: Re: Patch to fix imps2 emulation for usb mice in stable 2.2.X series
Date: Mon, 6 Mar 2000 18:25:58 +1100
Content-Type: text/plain
Cc: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.10.10003041853430.15981-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Message-Id: <00030618293200.03743@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 05 Mar 2000, Michael Schmitz wrote:

> You remind me of another USB mouse issue I stumbled on with 2.2.15: I had
> happily set up X to use the USB mouse as secondary mouse in the Xinput
> section for some time, when suddenly 2.2.15 changed the USB mouse
> behavior. All USB mouse clicks were doubled or tripled ...

My fault, I'm sorry, it seemed like a good idea at the time... :-)
That was before I knew how to tell XFree86 to use two mice.  I have
changed the #ifdef now.  If someone really wants this they can change the
ifdef or something.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
