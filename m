Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040118144412.GA6897@iliana>
References: <20040118144412.GA6897@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074443601.9704.164.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sun, 18 Jan 2004 17:33:21 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> >
> > > Finally, X works, altough DRI freezes after a second or two with my
> > > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > > DRI issue.

[...]

> As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
> using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
> including the mesa libraries, from the 4.3.0-0pre1v5 experimental
> package, rebuild with the Radeon 9200SE patch from Michel Daenzer.

You may want to try my dri-trunk-sid packages.

> The freeze happens when i first launch glxinfo, or when i first start
> moving a window around (using a debian/unstable default gnome desktop).
> I don't remember well, but i think it would also freeze when let running
> for a time, but i am not sure. The box is still available trough ssh,
> but killing the X server doesn't restore the fbdev console, and freeze
> the box.

Sounds like a typical chip lockup, possibly caused by the chip not
reading from the CP ring what we're writing to it.

Do you also have a server log with the DRI enabled?


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
