Message-ID: <37DC7E94.946FBA49@jlc.net>
Date: Mon, 13 Sep 1999 00:33:24 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC: porting to new platforms
References: <37DC6656.2A40D04D@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brendan Simon wrote:
> 
> I've been trying to get linuxppc running on a Motorola ADS board for
> some time now.  It seems that the ADS/FADS boards are quite horrible
> from the mail I've read on this list.  I have now decided to take the
> plunge and port it to a custom MPC860 board.

So, why don't you just consider the rest of the message I wrote
and buy a board with Linux/PPC already running?

> .... I am playing around with the 2.2.11 kernel sources which
> I got from a kernel mirror.  I notice that the support for BSE and RPX
> boards is not in this source.  Are there some PPC specific kernel
> archives I should be getting instead ?

Since I have had so much trouble just keeping up with the CVS
changes, I am way behind with updates.  Before I start updates,
I always put a tar image of the source tree on the linuxppc.cs.nmt.edu
server embedded directory.  You will find both 2.2.5 and 2.3.10
there right now, with the support for BSE and RPX boards.

> .......  What is the
> best way to go about this ?


Send them to me and I will merge them with the many other I get.
When it all fits together I'll check it into CVS.


>  ....Is it recommended to use the latest
> experimental kernels (2.3.x) or the latest 2.2 kerenl ?


I tend to work in the experimental kernels.  Everyone I work with
or talk to wants the features (and bug fixes) found in the latest
kernels.

I am nearly ready to post the first 8240 and 8260 changes.  The
8260 is an extension of the 8xx stuff today.  The 8xx is somewhat
changed to accomodate this, and will be in the 2.3.x kernels.


> ..  Is 2.2.11 ok to
> develop with or should I get the latest 2.2 kernel ?

Use the 2.3.10 tar image from the server.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
