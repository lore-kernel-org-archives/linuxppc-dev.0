Date: Mon, 9 Aug 1999 16:02:28 +1000
Message-Id: <199908090602.QAA13922@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: trini@disparity.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.BSF.3.96.990808165209.16262c-100000@silver.teardrop.net>
	(message from Tom Rini on Sun, 8 Aug 1999 16:55:01 -0400 (EDT))
Subject: Re: Trying a Promise Ultra/66 on powerpc
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.BSF.3.96.990808165209.16262c-100000@silver.teardrop.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@disparity.net> wrote:

> Would this be one of the things solved/cleaned up by seperating ide-pmac.c
> and the CONFIG option for it into generic enable IDE stuff and a driver
> for the builtin IDE on some machines?  Last I tried, I needed to enable
> both cmd646 and ide-pmac on myy blue&white (trying to do this is on my
> todo list, someplace.. :))

There's no problem about enabling both cmd646 and ide-pmac with the
current vger sources, is there?  You do need to select experimental
drivers as well as "Generic PCI IDE chipset support"
(CONFIG_BLK_DEV_IDEPCI) and "Generic PCI bus-master DMA support"
(CONFIG_BLK_DEV_IDEDMA) before you get asked about the CMD646, though.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
