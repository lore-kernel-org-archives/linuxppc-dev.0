Message-ID: <19990708080415.A822@radicalmedia.com>
Date: Thu, 8 Jul 1999 08:04:15 -0400
From: Mark Abene <phiber@radicalmedia.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: platinum video makes me cry...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The good news is that I finally got around to installing linuxppc-1999 (R5)
on my 7200.  The BAD news is that much to my chagrin, the changes I made to
fix the platinum video driver in the newer kernels (which I submitted to the
code maintainer nearly a month ago, if not more) are NOT present in R5!
I was greeted by the sickly-looking psychedelic arch-nemesis of Tux the penguin.
Suffice to say, gnome came up looking like a bad acid trip.
Sooooo, I'm rebuilding my kernel to make things right, but I'm irritated that
all you proud 7200/8200/PT120 users out there were let down.
If anyone out there is using one of these wonderful machines and is still
plagued by the psychedic penguin syndrome in 16 or 32 bpp, let me know, and
I'll stick the repaired platinumfb.c file somewhere for ya, or just e-mail it.

Credit where credit is due:  even though our good Mr. Herrenschmidt is busy 
making life easier for so many with BootX, he still came through and obviously
made sure my fixes for the TurboMouse 5 trackball were committed.  My mouse is
doing The Right Thing.  (Thanks Ben! :)

I'll be the first one to admit that we all get busy with Real Life stuff, it
just made me sad to see the console colors still all mucked-up.
Anyway, it's 8am here in NYC, and I've been up all night.
If I've offended anyone with my rant, I apologize in advance.

Feel free to mentally replace this message with "mouse good, console bad".
Good night, all.

-Mark


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
