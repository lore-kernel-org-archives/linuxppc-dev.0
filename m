Date: Mon, 28 Jun 1999 14:01:11 -0400 (EDT)
From: Peter Handel <phandel@cise.ufl.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with twm?
Message-ID: <Pine.GSO.4.05.9906281359520.4357-100000@eclipse.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


---------- Forwarded message ----------
Date: Mon, 28 Jun 99 19:10:16 MESZ
From: Wulf Hofbauer <wh@echo.chem.TU-Berlin.DE>
To: Peter Handel <phandel@cise.ufl.edu>
Subject: Re: Problems with twm?

> Since I upgraded to r5, my twm menus don't print the text unless I
> roll the mouse over them; this exact same .twmrc worked perfectly
> under r4.  Here's a segment of my .twmrc:
> 
> menu "hosts"
> {
> "Logins"        ("white":"DarkSlateGrey")       f.title
> "Local Shell"   !"xterm &" #theres more here
> ...
> "-----"         f.title
> "Exit"          ("white":"CornFlowerBlue") f.quit
> }
> 
> Is this the same thing you're experiencing?

Yep. So it's not just me :). I suspect the X server tries to optimize
away some expose events and screws up badly. I might check Xpmac to
see if the problem persists.

- Wulf


--
 ________________________________________________________
! Dipl. Phys. Wulf Hofbauer  (wh@echo.chem.tu-berlin.de) !
! Max-Volmer-Institut     Technische Universitaet Berlin !
! Strasse des 17. Juni 135     10623 Berlin      Germany !
!________________________________________________________!



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
