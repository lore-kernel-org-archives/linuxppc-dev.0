Date: Mon, 19 Jul 1999 12:26:35 +1000
Message-Id: <199907190226.MAA01159@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: barretp@mcmail.cis.mcmaster.ca
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user-digest@lists.linuxppc.org
In-reply-to: <v04003a00b3b7de41a7b6@[10.0.0.2]> (message from Paul Barrette on
	Sun, 18 Jul 1999 15:51:53 -0400)
Subject: Re: some progress: opening display /platinum@F8000000... failed
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v04003a00b3b7de41a7b6@[10.0.0.2]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Barrette <barretp@mcmail.cis.mcmaster.ca> wrote:

> NB it gave me the same problem! opening display /platinum@F8000000... failed

That message is a bit of a red herring, all it is telling you is that
OF doesn't have a method for initializing the platinum, but you knew
that anyway.  It just means that you can't use the video=ofonly
option.

There are some problems with the platinumfb driver.  Mark Abene posted
a message recently with a better version of the platinumfb driver.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
