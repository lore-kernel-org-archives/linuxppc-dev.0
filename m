Date: Mon, 19 Jan 2004 14:48:31 +0100
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040119134831.GA21093@iliana>
References: <20040118144412.GA6897@iliana> <1074443601.9704.164.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074443601.9704.164.camel@thor.asgaard.local>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> On Sun, 2004-01-18 at 15:44, Sven Luther wrote:
> > >
> > > > Finally, X works, altough DRI freezes after a second or two with my
> > > > radeon 9200SE, while it works for a Radeon 7500, but this is probably a
> > > > DRI issue.
>
> [...]
>
> > As for the DRI version, i use the drm module from the linuxppc-2.4 tree,
> > using the v2.4.24 TAG to checkout, and the rest of the XFree86 stuff,
> > including the mesa libraries, from the 4.3.0-0pre1v5 experimental
> > package, rebuild with the Radeon 9200SE patch from Michel Daenzer.
>
> You may want to try my dri-trunk-sid packages.

Just tried (all three packages) and my Radeon 9200 SE is not recognized :

(II) PCI: 10:08:0: chip 1002,5964 card 148c,2073 rev 01 class 03,00,00 hdr 00
...
(WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!
(EE) No devices detected.

Time for you to make another snapshot ? These where with the 2003.10.05
snapshot.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
