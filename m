Subject: Re: multiple separate pci bridges ...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040119134831.GA21093@iliana>
References: <20040118144412.GA6897@iliana>
	 <1074443601.9704.164.camel@thor.asgaard.local>
	 <20040119134831.GA21093@iliana>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074520948.9700.248.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 15:02:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-01-19 at 14:48, Sven Luther wrote:
> On Sun, Jan 18, 2004 at 05:33:21PM +0100, Michel Dänzer wrote:
> >
> > You may want to try my dri-trunk-sid packages.
>
> Just tried (all three packages) and my Radeon 9200 SE is not recognized :
>
> (II) PCI: 10:08:0: chip 1002,5964 card 148c,2073 rev 01 class 03,00,00 hdr 00
> ...
> (WW) ATI:  PCI/AGP Mach64 in slot 16:8:0 could not be detected!
> (EE) No devices detected.

Hmm.

daenzer@thor|14:50:01> grep 5964 /var/log/XFree86.0.log
        ATI Radeon 9200 5962 (AGP), ATI Radeon 9200SE 5964 (AGP),

If you have Driver "ati" in the Device section, does "radeon" make a
difference?

> Time for you to make another snapshot ?

Give me the time, and/or fix all the bugs (or at least the important
ones) in current DRI/Mesa CVS...


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
