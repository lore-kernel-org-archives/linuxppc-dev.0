Date: Thu, 9 Mar 2000 11:08:23 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Michael Thompson <mickey@berkeley.innomedia.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
In-Reply-To: <v03110700b4ed3e1295ce@[129.100.29.243]>
Message-ID: <Pine.LNX.3.96.1000309110424.18775C-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Mar 2000, Kevin B. Hendricks wrote:

> I just finished installing linuxppc 2000 on my brand new G4 450MHz box and
> every time I try to boot into my linux side with Bootx 1.2fc1 I get the
> exact same error messages:
>
> hdc: lost interrupt
> hdd: lost interrupt
>
> and on top of that
>
> usbcore: USB device not responding, giving up (error=-101).
>
> The funny thing is that the installation from the ramdisk went fine and the
> keyboard and things worked with no problem.
>
> I have tried the hda=noautotune .. hdb= ... hdc= to no avail.
>
> Is there something different about recent G4 450s that I need to worry about?

Does it work?  If so, then you're fine.  I've been running Benjamin
Herrenschmidt's iBook/* kernel on a G4/450 with the MkLinux distro, and
I've noticed these same messages at startup myself.  The box has been up
and running under heavy disk and keyboard load for 16 days now w/o a
crash.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
