Message-Id: <200002020357.WAA22504@mal-ach.watson.ibm.com>
To: khendricks@ivey.uwo.ca
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to keep gcc haifa from moving userlevel thread lock function?
In-Reply-To: Message from Kevin Hendricks <khendricks@ivey.uwo.ca>
   of "Tue, 01 Feb 2000 22:26:18 EST." <00020122402100.07553@localhost.localdomain>
Date: Tue, 01 Feb 2000 22:57:23 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Is _scheduling_lock delared volatile?  You should not disable
scheduling or other optimizations to solve this problem.  You should look
for the appropriate attribute for the variable and/or function to prevent
GCC from moving the code.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
