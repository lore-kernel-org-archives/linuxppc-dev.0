Date: Tue, 20 Jul 1999 13:47:47 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: puetzk6715@uni.edu, Yann Bizeul <yann@tynsoe.COM>,
        linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: X : caught signal 11 ?
In-Reply-To: <Pine.LNX.3.96L.990720102648.1737C-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.SOL.3.96.990720134513.19019A-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis,
I have the platinumfb too (7200), and I read your message, tried it and
bang, x
was down.  I recompiled the kernel with the new driver (I didn't get it
from your site it was mailed to me) and it is ok now.  I never had this
problem before with fvwm and accel X , maybe it is a Xpmac & the driver?

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator
McMaster University

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

On Tue, 20 Jul 1999, Hollis R Blanchard wrote:

> 
> On Tue, 20 Jul 1999 puetzk6715@uni.edu wrote:
> 
> > Well, I switch on and off all the time (I have 6 console VT's and 2 X
> > VT's). I used to get palette problems, but not since I applied anthony
> > tong's patch and rebuilt X. It never died (well, it did in my cobbled
> > pre-R5, but not in the released LinuxPPC 1999).
> 
> I see. What video driver are you using? Yann, you too? As I mentioned, I'm
> using platinumfb on a PowerCenter 132. I'm wondering if it's the driver. I
> just got Mark Abene's updated driver but haven't had a chance to try it yet
> (and won't for the rest of the week). For those of you who want to see if it
> fixes anything, I've put it up at
> http://www.andrew.cmu.edu/~hollis/platinumfb.c
> 
> -Hollis
> 
> 

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
