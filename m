Message-Id: <199906060055.TAA06757@www.cedarnet.org>
Date: Sat, 05 Jun 1999 19:57:16 -0500
Subject: Re: control-c [Re: Mac-on-linux is now working...]
From: "Kevin Puetz" <kp11901@cedarnet.org>
To: Brad Midgley <brad@turbolinux.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Actually it always does that on my machine - kind of annoying. That and mol
doesn't see my hard drives (they are IDE and don't have SCSI drivers on
them, I think that's why).

cntrl-c.. kills the emulator dead.

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
>From: Brad Midgley <brad@turbolinux.COM>
>To: Benjamin Herrenschmidt <bh40@calva.net>
>Cc: Brad Midgley <brad@turbolinux.COM>, linuxppc-dev@lists.linuxppc.ORG
>Subject: control-c [Re: Mac-on-linux is now working...]
>Date: Sat, Jun 5, 1999, 12:27 PM
>

>
> fyi, i found out that control-c doesn't stop mol if mol was started from
> my shell script. so it may be something to do with signal handling...
>
> perhaps when run from a script bash gets the control-c and sends the
> interrupt signal to mol but mol was looking for a raw control-c? maybe
> stty could change that behavior...
>
> Brad
> brad@pht.com | http://www.pht.com/~brad/
>
>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
