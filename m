Date: Wed, 31 Mar 1999 08:49:14 -0600 (CST)
From: nathan ingersoll <ningerso@d.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yesterday vger and ioremap (fwd)
Message-ID: <Pine.SO4.4.02.9903310848450.26194-100000@ub.d.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


---------- Forwarded message ----------
On Tue, Mar 30, 1999, Nathan Ingersoll <ningerso@d.umn.edu> wrote:

>I've noticed the ethernet part too. I've been working with the writer of the
>epic100 driver to get it working for PPC, but I haven't been able to test his
>changes since upgrading. I get a total lock up whenever I try to bring up the
>interface. It's not IP because I've been able to connect using PPP.

Cort just fixed the ioremap problem, I'll try again a kernel later today
or tomorrow, in the meantime, you may want to post the above message to
the dev mailing lists too so that other people know that it's not an
isolated problem (but I beleive we are not alone with that bug ;-)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
