Date: Tue, 18 Jan 2000 11:05:45 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Jim Potter <jrp@wvi.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM 405GP
In-Reply-To: <38849AFD.10C176AB@wvi.com>
Message-ID: <Pine.SGI.4.10.10001181102310.280417-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 18 Jan 2000, Jim Potter wrote:
> Has anyone been able to find any hardware based on IBM's 405GP core,
> and is anyone working on a Linux variant for this core?

Most people anxious to get working on this are awaiting non-MMU-hobbled
405GP silicon (i.e. > Rev. 1). In the interim, progress is forging ahead
on the 403GC[X] port. Please see:

	http://www.lcse.umn.edu/~grant/Linux/index.html

The 405GP is more or less functionally identical to the 403GCX with the
exception being that it has a slew of on-chip peripherals. The porting
work should really be focused on adding in support for those on-chip
peripherals. The other stuff (exception handling, MMU management, timer
code, etc) is mostly there already with the 403 port and should require
little, if any, modification to work with the 405GP.

Regards,

Grant Erickson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
