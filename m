Date: Tue, 13 Apr 1999 17:22:20 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Cannot telnet into pre-R5 board (PAM?)
Message-ID: <Pine.SO4.4.05.9904131707080.18847-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a small problem that I would like to see fixed. I'm running
a pre-R5 on our MVME2306 board. I cannot telnet to the board, i.e.
I get the login prompt, but always ``Login incorrect''. 

First I thought it was because I tried to login as root. So I tried 
to create a new non-root account, which fails. When I do a ``useradd'', 
followed by a ``passwd'', then the passwd fails with ``passwd: permission
denied'' (what permission ?).

I strongly suspect PAM being responsible for all this, but I have no
experience whatsoever with PAM. It seems to me that the /etc/pam.d/
are all correct.

Can anybody please help ?

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Fortunately, Hill Giants have large blind  spots in
 which a human can easily hide. Unfortunately, these
 blind spots are beneath the bottoms of their feet."
 - 'Hill Giant' (M:TG)
+-----------------------------------------------------------------+



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
