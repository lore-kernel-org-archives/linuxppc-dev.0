Message-Id: <5.1.0.14.2.20030715091031.029e37b0@mail.ebshome.net>
Date: Tue, 15 Jul 2003 09:20:24 -0700
To: Tom Rini <trini@kernel.crashing.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030715154656.GQ1211@ip68-0-152-218.tc.ph.cox.net>
References: <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
 <5.1.0.14.2.20030714210220.0308a070@mail.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:46 AM 7/15/2003, Tom Rini wrote:
>Well, one thing that is worth noting is that the USB people knew this
>was a problem, and it was / should have been fixed in the 2.5 cycle.
>Similarly, SCSI was cleaned up a lot, so perhaps this has been fixed
>there.  I think it's generally known that doing DMA off of the stack is
>a bad idea, and should be fixed when found.

I agree this is VERY bad idea but the fact is that there is a code which
does such nasty things.

I truly hope all this will/was fixed in 2.5 but frankly I wouldn't be so
sure :)

Unfortunately, for production 2.5 is unusable and will be for some time.
A lot of people (I think majority) still use 2.4. And 2.4 (as of
2.4.22-pre6) is still broken in this respect...

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
