Message-ID: <3FD84905.5090802@bluewin.ch>
Date: Thu, 11 Dec 2003 11:37:57 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 TLB miss reduction
References: <3FBD5348000912F8@mssbzhh-int.msg.bluewin.ch> <3FD75312.7070701@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 12/10/2003 06:08 PM Dan Malek wrote:
> Wolfgang Grandegger wrote:
>
>> ....We
>> can regain a few percent by using the kernel option CONFIG_PIN_TLB
>> but we are thinking about further kernel modifications to reduce
>> TLB misses. What comes into my mind is:
>
> If you have a large application I doubt any kernel modification
> will gain much.  It's the application causing the huge amounts
> of tlb misses, you probably need to evaluate changes that will
> reduce that.
>
> It's always easy to pick on the kernel and make some changes
> becaue it is a very static and well behaved application.  It
> seems your biggest performance increase would come from the
> analysis of the application and some redesign to improve its
> use of system resources.

We have been surprised, that CONFIG_PIN_TLB was able to reduce the page
miss rate already by approx. 40%. We are also working on the
optimization/tuning of our application and likely there we can gain more
than by further squeezing the TBL management of the Linux kernel, I agree.

Thanks.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
