Message-ID: <38E3998D.44D79AFB@wanadoo.fr>
Date: Thu, 30 Mar 2000 20:14:37 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
References: <Pine.LNX.4.10.10003301834110.2052-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> OK, that's indeed not covered by the standard adb_buttons syntax. Funny
> binding - how do you get a left+right button press in Xpmac?

Standard Xpmac:
button 2 (middle): emulated by Opt + 2 and also by LeftOption  +
mouseclick
button 3 (right) : emulated by Opt + 3 and also by RightOption +
mouseclick

This supposes, of course, that you have a keyboard that has 2 Option
keys (keycodes called LALT and RALT). And that the handler of your
keyboard is set to 3 and not to 2 (left=right) nor to 5 (no modifiers,
at least for me).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
