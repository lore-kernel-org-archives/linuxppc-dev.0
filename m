Date: Thu, 8 Jul 1999 11:55:06 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: Albrecht Dreﬂ <ad@MPIfR-Bonn.MPG.de>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-user@lists.linuxppc.org,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
In-Reply-To: <3784BDFA.B302AEA7@mpifr-bonn.mpg.de>
Message-ID: <Pine.GSO.4.05.9907081145280.1822-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 1999, Albrecht [iso-8859-1] Dreﬂ wrote:

> o compiling linux-2.2.10 from kernel.org WITH EXACTLY THE SAME .config, the
>   media bay works fine, but the nfs server dies with the nfssrv error.
> 
> ?????????Where are the inconsistencies???????

Looks like it's time to bust out "diff" ... You could write a quick
/bin/sh script that does something like:

for DFILE in `find /usr/src/linux-1 -name \* -print`; do
  diff $DFILE /usr/src/linux-2/$DFILE # > $DFILE.diff
done

(uncomment the > $DFILE.diff if you want the diffs in a file instead
of to stdout)

...although I bet they're just different ac releases of 2.2.10.


Thanks,
Pete

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16
> > You are perfectly free to believe what you want to, and so am I.
> Actually, this turns out not to be the case. God does not give us
> the freedom to believe anything we wish. We are morally obligated to
> believe the truth. Doing anything else is a sin. You are not free to
> interpret the Bible anyway you wish. -DFL (Pretty neat, huh?)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
