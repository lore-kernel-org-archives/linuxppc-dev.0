Message-Id: <199906102032.WAA25167@denx.muc.de>
To: linuxppc-dev@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.muc.de>
Subject: Wrong parameters for m8xx_gorom() in 2.2.5 / MPC8xx
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jun 1999 22:24:11 +0200."
Date: Thu, 10 Jun 1999 22:32:30 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A small followup too my  previous  summary  of  my  first  experience
porting 2.2.5 to MPC8xx boards:

arch/ppc/kernel/setup.c says:	extern void m8xx_gorom(void);

arch/ppc/kernel/head.S says:
  r3 is the board info structure, r4 is the location for starting.

At least one of them is wrong. [BTW: the board  info  data  is  never
accessed, so why pass it?]

Wolfgang Denk

-- 
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"UNIX was not designed to stop you from doing stupid things,  because
that would also stop you from doing clever things."       - Doug Gwyn

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
