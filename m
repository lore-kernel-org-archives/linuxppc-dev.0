Date: Tue, 24 Sep 2002 15:22:20 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linear Aperture not available; Mach64 and X4.2.0
In-Reply-To: <20020924063335.6655.qmail@kunk.jriver.com>
Message-ID: <Pine.BSF.4.44.0209241519590.7261-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The Mach64GX is unlike other Mach64's in that it doesn't use an internal
ATI DAC but an external IBMRGB dac, and accessing this DAC isn't yet
supported for ppc in X 4.2.0.  Hopefully someone will find some time in
the future to get this working.  I suggest you use the "fbdev" driver
instead if you want to use 4.2.0, or use Xpmac if you want acceleration.


ani


On Tue, 24 Sep 2002, Robert E Brose II wrote:

>
> Does anyone know if (and where) this problem has been resolved?
> I assume there is some conflict in the default memory mapping?
>
>
> 00:0d.0 VGA compatible controller: ATI Technologies Inc 210888GX [Mach64 GX] (rev 02) (prog-if 00 [VGA])
>         Flags: stepping, medium devsel, IRQ 23
>         Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>
>
>
> XFree86 Version 4.2.0 (echo Yellow Dog Linux release: 4.2.0-6.30e) / X Window System
> (protocol Version 11, revision 0, vendor release 6600)
> Release Date: 23 January 2002
> 	If the server is older than 6-12 months, or if your card is
> 	newer than the above date, look for a newer version before
> 	reporting problems.  (See http://www.XFree86.Org/)
> Build Operating System: Linux 2.4.19-3b ppc [ELF]
> Build Host: kaelta.terraplex.com
>
> Module Loader present
> Markers: (--) probed, (**) from config file, (==) default setting,
>          (++) from command line, (!!) notice, (II) informational,
>          (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> (==) Log file: "/var/log/XFree86.0.log", Time: Tue Sep 24 01:30:27 2002
> (==) Using config file: "/etc/X11/XF86Config-4"
> (WW) ATI(0): Unknown RAMDAC type 0x95 detected.
> (EE) ATI(0): Linear aperture not available.
> (EE) Screen(s) found, but none have a usable configuration.
>
> Fatal server error:
> no screens found
>
> When reporting a problem related to a server crash, please send
> the full server output, not just the last messages.
> This can be found in the log file "/var/log/XFree86.0.log".
> Please report problems to xfree86@xfree86.org.
>
>
> (supermac s900, 6 slot pci bus, g3 350, worked with xpmac)
>
> Thanks,
> Bob
> --
> /~\ The ASCII       | Robert E. Brose II    N0QBJ
> \ / Ribbon Campaign | http://www.qbjnet.com/
>  X  Help cure       | mailto:bob@qbjnet.com
> / \ HTML Email      | public key at http://www.qbjnet.com/key.html
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
