Message-Id: <199906231305.IAA26387@www.cedarnet.org>
Date: Wed, 23 Jun 1999 08:08:01 -0500
Subject: Re: PowerBook sleep, first try
From: "Kevin Puetz" <kp11901@cedarnet.org>
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cool! Is there any hope of this working on the desktop machines that can 
sleep? (I like my machine getting quiet when not in use, though I can live
without.).

--
+--------------------------------------------------------------------+
|            .-'''''-.       Kevin Puetz                             |
|          .'   _/|   `.                                             |
|         :   =/_/      :    kp11901@cedarnet.org -preferred         |
|        :   _/ |        :   Kevin.Puetz@039-server.pls.uni.edu      |
|       (\  /  ,|        :   webmaster@039-server.pls.uni.edu        |
|        \\/^\/||__     :                                            |
|     _/~`~`""~`"` \_ .'  "Could you please continue the petty       |
|  __/  -'/  `-._ `\_\__   bickering?  I find it - most intriguing." |
|/     /-'`  `\   \  \-.\    --Data, STTNG, "Haven"                  |
+--------------------------------------------------------------------+

----------
>From: Benjamin Herrenschmidt <bh40@calva.net>
>To: linuxppc-dev@lists.linuxppc.ORG
>Cc: kevyn@apple.COM, Paul.Mackerras@cs.anu.edu.au, huberj@WPI.EDU
>Subject: PowerBook sleep, first try
>Date: Wed, Jun 23, 1999, 3:43 AM
>

>
> Hi !
>
> I've uploaded a first-try implementation of sleep on PowerBook G3 Series
> (Grackle/mac-io based). It's NOT functional yet, it still hangs when
> waking up. However, it no longer resets the machine, so it looks like the
> ROM code is correctly identifying the wakeup code when the CPU is powered
> back on.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
