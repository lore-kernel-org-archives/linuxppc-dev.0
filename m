Date: Thu, 30 Mar 2000 10:02:51 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@linuxcare.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
In-Reply-To: <38E27BDD.4DEDC1E4@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10003300955350.19014-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Well, change the documentation. I think somebody is integrating my xpmac-style
> > adb_buttons support and so there will be a adb_buttons=2,xx,yy soon. I think
> > the old syntax was a little bit strange anyway and probably was only a mistake
> > and no intended behaviour.
>
> Yes, please! I have been using the adb_buttons=2,xx,yy patch for more
> than a year now on both 2.2.x and 2.3.x. It would be nice to have it
> integrated in the kernel, so I don't have to patch it every time. If
> someone wants a version for 2.3.99, I can mail it.

Could you please describe what adb_buttons=2,xx,yy does different than
adb_buttons=xx,yy (2.2 style) would do?
Please keep in mind that the adb mouse code is shared with the m68k Mac
port. I'm sure people there would like to get a heads-up about changes to
the syntax too.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
