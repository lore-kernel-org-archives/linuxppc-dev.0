Date: Tue, 10 Aug 1999 16:06:17 +1000
Message-Id: <199908100606.QAA23344@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: pberge@stny.rr.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <37AFA3A3.370B25CB@stny.rr.com> (message from Patrick Berge on
	Mon, 09 Aug 1999 23:59:31 -0400)
Subject: Re: mace:transmit timeout - resetting
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37AFA3A3.370B25CB@stny.rr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Patrick Berge <pberge@stny.rr.com> wrote:

>  I have am receiving "mace:transmit timeout - resetting" sporadically.

But do you see any problems with the network apart from the message?

The reason for the message is that there are some bugs in the mace
chip which cause it to lock up very occasionally.  When the driver
detects this condition, it prints this message and tries to reset the
chip.  If your network keeps working, then it means that the driver
successfully got the mace chip going again.

> Any ideas about my problem and/or the meaning of the HZ would be
> helpful.

HZ is the number of timer interrupts per second.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
