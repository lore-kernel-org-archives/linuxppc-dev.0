In-Reply-To: <Pine.LNX.4.60.0407240909090.12370@localhost.localdomain>
References: <Pine.LNX.4.60.0407240909090.12370@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7F9106EE-DDEB-11D8-B7F9-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: couple questions about MPC8xx CPM Options menu
Date: Sat, 24 Jul 2004 23:34:13 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 24, 2004, at 9:14 AM, Robert P. J. Day wrote:

>   the first has a help entry that refers, not to the 860, but to the
> 8260 (making it out of place here).

As we have told you before, the help information is picked up
in a weird way due to similar configuration options for the 8260.
The 860T was the first processor with the FEC peripheral block.
If you have an FEC, ask to have it configured, if you don't have
it, don't configure it.

>   and the second, while being in the 8xx family, is still displayed
> even after choosing a platform that's not an 860.

As I have pointed out in a previous message, we don't distinguish
among the 8xx variants in either the configuration or in the
Linux software.  If you have a processor that requires the CPU6
errata workaround, then configure this option, otherwise don't.
It first appeared in silicon prior to 860 Rev. C, but also affected
others.

>   this is the sort of confusion i was talking about in my earlier
> emails.

There is no confusion.  All types of kernel configuration for
nearly any platform will present options that you must be
smart enough to select or to not select depending upon your
board configuration.  Based on the questions you continue
to ask, you are very aware of what you need.  Just configure
your kernel and get on with things.

If you want something different, submit a patch for consideration
that changes the behavior.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
