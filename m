Date: Tue, 14 Mar 2000 22:10:28 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Michel Dänzer <michdaen@iiic.ethz.ch>, Kostas Gewrgiou <gewrgiou@imbc.gr>,
        "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to workonppcwithr128
In-Reply-To: <Pine.LNX.4.10.10003141911250.17573-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10003142207130.18335-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Do you use BackingStore? If yes, can you try leaving it off?
>
> Nope, and that's not where it hangs anyway. I just didn't get all of the
> server output in that case (fflush (stderr) isn't sufficient).
> Now I can't get beyond xf86HandleColormaps(). Another ioctl that barfs on
> me, perhaps. I guess it all boils down to PCI messups.

After bypassing xf86HandleColormaps()  get all the way through the screen
init (including FBDevRefreshArea calls that appear to be writing to video
memory without choking), only to hang a couple of seconds after. I'll dig
into the kernel ioctl problems now - there will be the cause of the
colormap failures as well.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
