Date: Thu, 30 Mar 2000 19:19:56 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
In-Reply-To: <38E367DE.E740FCCD@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10003301834110.2052-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Could you please describe what adb_buttons=2,xx,yy does different than
> > adb_buttons=xx,yy (2.2 style) would do?
> > Please keep in mind that the adb mouse code is shared with the m68k Mac
> > port. I'm sure people there would like to get a heads-up about changes to
> > the syntax too.
>
> It defines key_xx + mouseclick as middle button and key_yy + mouseclick
> as right button. This is one of the two default bindings of Xpmac, which
> has Opt_left+click and Opt_right+click as buttons 2 and 3. I use
> adb_buttons=2,58,124 to get the same also in the console (with gpm) and
> in XF_FBDev.

OK, that's indeed not covered by the standard adb_buttons syntax. Funny
binding - how do you get a left+right button press in Xpmac?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
