Message-Id: <l03130300b2a6e21c2a5d@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 24 Dec 1998 07:15:35 +1300
To: linuxppc-dev@lists.linuxppc.org
From: Bryan Christianson <bryanc@ihug.co.nz>
Subject: egcs 1.1.1 and outl
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am running Kernel 2.0.130 compiled with egcs 1.0.2. I upgraded the
compiler to egcs 1.1.1 and recompiled the driver I'm working on. The driver
crashed the machine on its first call to outl with amessage saying
something like 'invalid msr' and then a dump of all the registers.

I've reverted back to egcs 1.0.2 and the driver works fine.

Is this a known issue - couldn't find anything in the FAQ.

I can reproduce it and get more detail if required. I presume this is a
problem with the compiler unless there is something weird with the code for
outl in <io.h>

--
Bryan Christianson
email:		<mailto:bryanc@ihug.co.nz>
Home Page:	<http://crash.ihug.co.nz/~bryanc>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
