Message-Id: <4.2.0.37.19990503143536.036c9a30@mail.lauterbach.com>
Date: Mon, 03 May 1999 14:44:13 +0200
To: Richard Henderson <rth@cygnus.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems
Cc: egcs-patches@egcs.cygnus.com, meissner@cygnus.com,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990430150834.G30433@cygnus.com>
References: <4.2.0.37.19990430153444.048303a0@mail.lauterbach.com>
 <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
 <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
 <19990429194817.B20300@cygnus.com>
 <4.2.0.37.19990430153444.048303a0@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:08 01.05.99 , Richard Henderson wrote:
> > Can you check in this stuff in that shape?
>
>Done.

Thanks.

> > And maybe the second part (the
> > gnuplot fix) of my patch if it is OK and the testcase?
>
>I'll look at this again later tonight or tomorrow -- despite
>the subject line, I'd missed the fact that you were trying to
>fix two separate problems.

I did look at the argument handling again yesterday, and I now think there 
might be additional bugs in the handling of CUMULATIVE_ARGS->words for the 
SYSV ABI case. I'll try to construct testcases for the suspect cases.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
