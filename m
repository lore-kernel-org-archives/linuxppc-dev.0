Message-Id: <199907210848.DAA25068@lists.linuxppc.org>
Date: Wed, 21 Jul 1999 10:54:13 +0100
Subject: Re : X : caught signal 11 ?
From: "Yann Bizeul" <yann@tynsoe.com>
To: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>,
        Hollis R Blanchard <hollis+@andrew.cmu.edu>
CC: puetzk6715@uni.edu, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

> Hollis,
> I have the platinumfb too (7200), and I read your message, tried it and
> bang, x
> was down.  I recompiled the kernel with the new driver (I didn't get it
> from your site it was mailed to me) and it is ok now.  I never had this
> problem before with fvwm and accel X , maybe it is a Xpmac & the driver?

Which new driver do u use ?

I have recompiled the most recent stable kernel (2.2.10) and did not correct
that :'(

Thanks !
> --------
> Paul Barrette
> Ph.D. Candidate Classics (Latin Literature)
> System Administrator
> McMaster University
>
> "Oppositaque ad os manu nescio quid taetrum
> exsibilavit, quod postea Graecum esse affirmabat."
>                                       --Petronius
>
> On Tue, 20 Jul 1999, Hollis R Blanchard wrote:
>
>>
>> On Tue, 20 Jul 1999 puetzk6715@uni.edu wrote:
>>
>> > Well, I switch on and off all the time (I have 6 console VT's and 2 X
>> > VT's). I used to get palette problems, but not since I applied anthony
>> > tong's patch and rebuilt X. It never died (well, it did in my cobbled
>> > pre-R5, but not in the released LinuxPPC 1999).
>>
>> I see. What video driver are you using? Yann, you too? As I mentioned, I'm
>> using platinumfb on a PowerCenter 132. I'm wondering if it's the driver. I
>> just got Mark Abene's updated driver but haven't had a chance to try it yet
>> (and won't for the rest of the week). For those of you who want to see if it
>> fixes anything, I've put it up at
>> http://www.andrew.cmu.edu/~hollis/platinumfb.c
>>
>> -Hollis
>>
>>

>>
>
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
