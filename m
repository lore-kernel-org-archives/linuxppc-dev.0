Date: Mon, 8 Mar 1999 08:13:48 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org
Subject: platinumfb problems
In-Reply-To: <Pine.LNX.4.03.9903081025140.8012-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96L.990308080845.1015A-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Mar 1999, Geert Uytterhoeven wrote:

>   - To pass options to a specific frame buffer device:
> 
> 	video=fbdev:opt1:val1
> 	video=fbdev:opt1:val1,opt2:val2
> 	video=fbdev:opt1:val1,opt2:val2,opt3:val3

That's too bad. That means I'd remembered correctly.

Using the cmdline "root=/dev/sdb5 video=platinumfb:vmode:17,cmode:8" (from
/proc/cmdline), Linux starts in screwed up palette mode, which would seem to
indicate 16bit color (I'm running X great in 8bit, but trying to use 16bit
makes for an annoying palette).

It seems that with platinumfb, 16bit color is wrong in both console and X.
'vmode 17 8' in console and 'startx -- -depth 8' make the colors sane again.

>From /var/log/dmesg:
Monitor sense value = 0x60b, using video mode 17 and color mode 1.

Color mode 1, eh?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
