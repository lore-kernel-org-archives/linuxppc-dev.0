Message-ID: <38851.193.133.92.239.994925353.squirrel@lbbrown.homeip.net>
Date: Thu, 12 Jul 2001 09:09:13 +0100 (BST)
Subject: Booting 43P-140
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Reply-To: leigh@solinno.co.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I forward ported Todd Inglett's 43P-140 patches to 2.4.7pre4 and tried to
boot - no joy.  I then found a 43P-140 image on SuSE's web site and tried
that - no joy.  Here are the steps I took:

1. I dd'd the image onto a floppy (get some result with both images)
2. I set the bootlist in AIX to floppy followed by hdisk0.
3. I set up the machine to boot from tty0 (using my trusty Psion 5).
4. I boot the machine, it displays the "Loading Software" screen on
   the terminal and reads about the right amount of data from the floppy.
5. I get no messages, just a newline emitted at the end - the LED gets
   stuck on F05 (I think, I didn't write it down).

Pointers to what to do next would be gratefully received - I am very keen
on getting Linux going on this box (I couldn't afford a bigger one :-) and
will be able to help with testing kernels and so on once its up and running.

Cheers,

Leigh.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
