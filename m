Message-ID: <38E367DE.E740FCCD@wanadoo.fr>
Date: Thu, 30 Mar 2000 16:42:38 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
References: <Pine.LNX.4.10.10003300955350.19014-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> Could you please describe what adb_buttons=2,xx,yy does different than
> adb_buttons=xx,yy (2.2 style) would do?
> Please keep in mind that the adb mouse code is shared with the m68k Mac
> port. I'm sure people there would like to get a heads-up about changes to
> the syntax too.

It defines key_xx + mouseclick as middle button and key_yy + mouseclick
as right button. This is one of the two default bindings of Xpmac, which
has Opt_left+click and Opt_right+click as buttons 2 and 3. I use
adb_buttons=2,58,124 to get the same also in the console (with gpm) and
in XF_FBDev.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
