Date: Wed, 15 Nov 2000 15:29:13 -0700 (MST)
From: Derrik Pates <dpates@andromeda.dsdk12.net>
To: "Keith W. Shaw" <keithws@fork.yi.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: AWACS sound support with 2.4.0-test10 from linuxcare.com
In-Reply-To: <Pine.LNX.4.21.0011151417510.21455-100000@dizzy.fork.yi.org>
Message-ID: <Pine.LNX.4.30.0011151527540.29263-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Nov 2000, Keith W. Shaw wrote:

> I was able to fix that problem by re-enabling "Support for CUDA
> based PowerMacs" in "Macintosh device drivers" which i had zealously
> turned off thinking i didn't need it. I had also disabled MacIO support,
> but I'm not sure if that was it.  I now just leave all items in that sub
> section selected.  Not absolutely sure, but that seemed to work for me.

I discovered my problem - I built in the ERTC driver, which apparently is
x86 only, and it always took IRQ 8, which the AWACS driver wanted
desperately.

The mixer control is still nasty broken, but hey, it's progress.

Derrik Pates      | Sysadmin, Douglas School|    _   #linuxOS on EFnet
dpates@dsdk12.net |  District (dsdk12.net)  |   | |   and now OPN too!
   Student @ South Dakota School of Mines   | __| |___ _ _ _   ___ _ _   ____
       & Technology (www.sdsmt.edu)         |/ _  / -_) ' \ '\/ _ \ ' \ (____)
UNIX: Because you want to USE your computer.|\___,\___|_||_||_\___/_||_|


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
