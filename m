Message-ID: <3FD8A1A8.2060409@bluewin.ch>
Date: Thu, 11 Dec 2003 17:56:08 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch> <3FD75312.7070701@embeddededge.com> <3FD84905.5090802@bluewin.ch> <3FD89FC3.3020301@jonmasters.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 12/11/2003 05:48 PM Jon Masters wrote:
>
> Wolfgang Grandegger wrote:
>
> | We have been surprised, that CONFIG_PIN_TLB was able to reduce the page
> | miss rate already by approx. 40%. We are also working on the
> | optimization/tuning of our application and likely there we can gain more
> | than by further squeezing the TBL management of the Linux kernel, I agree.
>
> I noticed a possible improvement in performance however have not yet
> done a set of tests to back this up. I saw the huge TLB stuff in
> 2.6.0-test11 and nearly fell off my chair - can someone here provide
> some reference to read on this so I can be more useful talking about it?

I found "Documentation/vm/hugetlbpage.txt" in linuxppc-2.5 from BK.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
