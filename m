Message-ID: <3B699332.4D76ADD3@mvista.com>
Date: Thu, 02 Aug 2001 13:51:46 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How do I mask an interrupt from 8xx
References: <20010802072042.46728.qmail@web20107.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Francis wrote:

> I need to mask an IRQ when I aam servicing interrupt
> service routine for the same IRQ.

That's already done for you by the first phase interrupt
handler.  If it doesn't appear to be working, send me
more information about what you are doing and why you
think there is a problem.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
