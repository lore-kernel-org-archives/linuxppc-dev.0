Message-ID: <398FC8FB.E4423F51@relog.ch>
Date: Tue, 08 Aug 2000 10:46:51 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Sven Goethel <sgoethel@jausoft.com>
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC
 XServer))
References: <Pine.LNX.4.21.0008072058480.21201-100000@idd-01.imbc.gr> <398F1346.B81B3756@jausoft.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sven Goethel wrote:

>         - which kernel ? (I currently use 2.4.0-test5)

That should be fine, at least it works for me with test4 and test6 :)

>         - XF4.0.1 ?

Maybe. I've got it working using the DRI CVS trunk, but the differences
against X4.0.1 are minor.

>         - When and/or where can I get the working r128 linux kernel
>           sources for ppc - they seemed not to be included in the current
>           CVS tree.
>           I only get a LOCK_PREFIX unknown ...

Apply the patch I have posted to the linuxppc-dev list yesterday. I can send
it to you privately if you can't get it for some reason.


Michel


--
The computer revolution is over. The computers won.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
