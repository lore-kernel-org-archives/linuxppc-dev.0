Date: Tue, 17 Aug 1999 21:29:06 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
        recipient list not shown: ;
Subject: Re: Bugs in xfree68 that made it fail with jdk 1.2.1 found and fixed
 (fwd)
In-Reply-To: <Pine.LNX.4.10.9908171952200.30397-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.10.9908172112330.17823-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 17 Aug 1999, Geert Uytterhoeven wrote:

> 
> Anybody who'd care to try? I just erased my XFree86 3.3.x tree.
> 
> BTW, I'm always willing to test a glibc-2.1 binary :-)
>

 I had to erase my build of 3.9.15x to make space for the 3.3.x build *sigh* :(

I'll have a binary in a few hours if you are intrested (Builds take a looong
time in my 604@132). I have to see if i can fix the no video drivers and the
Modes "default" case first (and write a cleaner patch ;).


  Kostas Gewrgiou.

PS> if i could fix the acceleration problems in my aty mach64gx also i'll be a
happy man, too slow without accel too much noise with accel :(
 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
