Message-Id: <199905301326.IAA26669@lists.linuxppc.org>
Date: Sun, 30 May 1999 15:26:07 +0200 (CEST)
From: laures@esiea.fr
Subject: Pcmcia-cs
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just wanted to know if someone was working on this.

I just compiled the 3.0.9 version with a vger 2.2.10 kernel, and when I
insert a card the machine (WallStreet) hangs (cursor blinking at top
left of the screen).

Otherwise if I put it in at startup time, the kernel dumps a little more
insteresting feedback (kernel access to bad area, pc=...)

The compilation went fine (and given the number of built-in equipment in
Apple laptops) I guess that this problem simply has not been
enlightened. Am I true ?

I'd like to use a 10/100 card from MacSense Tech. BTW, they told me that
teir engineers where "playing" with linux to figure out how difficult
support for this OS would be.

-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
