Message-ID: <XFMail.990212153005.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.A41.3.95a.990212160439.43344B-100000@rsplus06.cern.ch>
Date: Fri, 12 Feb 1999 15:30:05 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Marc Dejardin <Marc.Dejardin@cern.ch>
Subject: RE: Problem with 2.2.1 compilation
Cc: linuxppc-dev@lists.linuxppc.org, Gary Thomas <gdt@linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 12-Feb-99 Marc Dejardin wrote:
> On Fri, 12 Feb 1999, Gary Thomas wrote:
> 
>> I don't want to get into or repeat a *very lengthy* discussion here, but this
>> is an artifact of EGCS and inline functions.  It basically boils down to the
>> fact that running without -On and inline functions (the way they are used
>> by the Linux kernel) just doesn't jive.
>> 
>> Is there some reason (other than your instability which I understand) that
>> you want to do this?  BTW - Linux 2.2.1 is incredibly stable on my PreP box,
>> so I have little fear in the compiler, at least for the non-PowerMac specific
>> stuff.
>> 
> 
> Thanks for the answer !
> 
> My problem is that I have regural crashes (kernel panic) with recents kernels
> when I run Xpmac or XF68_FBDev. (see January archive)
> It seems that I am the only people in this situation on this earth, so I am
> trying to solve my problem with my own and humble capacities.
> Since I am not a guru neither an expert, I just play with only tuning
> capapbilities I got. Compiler optimiser is one of them.
> 
> By the way, I have not crashed since I run with the 2.2.1 kernel compile with
> -O1 option. Ok It is just 10 hours old but it smells better than before.
> 
> I agree that it could hide some other problems like hardware ones... but if the
> problem is a timing problem with hardware, running a little bit slower could
> help. In fact I am more or less convince that my problem is linked to harware
> due to the fact that I have never succeeded to make the virtual memory
> working correctly with MacOS (7-5-3 to 8-5-1). But if I send my old 8500/180 to
> repair it will cost me the price of a new iMac... and I am even not sure that it
> will work correctly after.
> 

Sounds like your hardware may be a bit shakey...

> What bothers me is that it was working like a charm with 2.1.24 (just normal
> shut down for hollidays and no crash for weeks). The point is that it seems
> that X seems to work slightly faster with recent kernel ... Is it just an
> illusion ?
> 

Indeed the newer kernels are quite fast!  Also, 2.1.24 is pretty old, a lot
changed in ~100 revision...

Hopefully someone closer to the PowerMac side can help more.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
