Date: Sun, 21 Jan 2001 22:36:37 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: dri status? (agpgart?)
Message-ID: <20010121223637.A32549@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

I am just now grabbing the cvs repository from dri.sourceforge.net to see if
I can get dri running on my pismo, now I am wondering what the current
status is?

(I am of course doing this because gareth hughs was at linux.conf.au over
the last few days, and I was completely blown away by the performance of 3d
stuff on his laptop (it was absolutely amazing to say the least))

Last I heard for ppc was that we could do dri but not the agpgart stuff,
which means it doesnt go quite as fast as we may wish (no mtrr write
combining or some such) but it does handle stuff like complex textures and
such damn nicely. Is this still the case?

Anyway I suppose I will find out in a while what it works like on the pismo
currently.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
