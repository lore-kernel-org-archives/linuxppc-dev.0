From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: current->mm
Date: Thu, 6 Jun 2002 12:25:48 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJIEFMCFAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I'm running a 2.4.18 kernel on a 862/857 board.
In some codes related to pag allocation there's a myterious problem where
current->mm is zero.
I don't know anything about current current->mm except that it may be the
memory list of the current contex. But I think it should not be zero after a
page was allocated...
Any know issues in that direction?

Thanks 4 ur help, Stephan


#--
 STEPHAN LINKE (dipl. inform); software engineer
 epygi labs de  gmbh;  herrenstraﬂe 23, 3. og, D-76133 karlsruhe
 http://www.epygi.de;  mailto:stephan.linke@epygi.de
 phone 0721-20596-30;  fax 0721-20596-59
----------------------------------------
Motto: ÑWenn es defekt ist, dann isses kaputt!ì


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
