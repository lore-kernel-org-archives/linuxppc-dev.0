Message-Id: <l03130300b318197a55c0@[141.213.6.226]>
In-Reply-To: <199903171635.IAA05093@sb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 19 Mar 1999 10:16:05 -0500
To: "Emmanuel STAPF" <manu@sb.net>, linuxppc-dev@lists.linuxppc.org
From: mukesh agrawal <agrawal@ais.org>
Subject: Re: Missing definition of SIGCLD from "signum.h"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:37 AM -0500 3/18/99, Emmanuel STAPF wrote:
>Has someone an idea why SIGCLD is not defined in signum.h? On the standard
>PC distribution it is defined as SIGCHLD but on LinuxPPC there is no
>definition.
>
>If there is no reason, how can someone add it to the standard distribution?

I think SIGCLD is the historical name for SIGCHLD. The use of SIGCLD is
probably deprecated. Since LinuxPPC is new, probably nobody thought it
necessary.

FWIW, SIGCHLD is the Unix98 way of doing things.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
