Message-Id: <5.1.1.6.2.20030528150729.0128bdf0@corelis.com>
Date: Wed, 28 May 2003 15:16:42 -0700
To: Wolfgang Denk <wd@denx.de>
From: "Brian S. Park" <brian@corelis.com>
Subject: Re: getting Linux working on IBM Walnut demo board 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030528213503.9676EC6162@atlas.denx.de>
References: <Your message of "Wed, 28 May 2003 13:53:08 PDT." <5.1.1.6.2.20030528132553.0128a2f0@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you Wolfgang,
That was it. I forgot to run those script.
After running the script, the console works and I can telnet without any
problem.

Now I can start hacking and get it customized for our custom target.

Thank you all for helping me get it up and running.

Brian


At 11:34 PM 5/28/2003 +0200, Wolfgang Denk wrote:
>Dear Brian,
>
>in message <5.1.1.6.2.20030528132553.0128a2f0@corelis.com> you wrote:
> >
> > It turned out that ELDK default setup does not have any dev files. How do I
> > create all the dev files I need?
>
>Well, I recommend you start reading the documentation now.
>
>There is a section "7. Mounting  Target  Components  via  NFS"  which
>explains  that  you  have  to  run the ELDK_MAKEDEV and ELDK_FIXOWNER
>scripts.
>

===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
