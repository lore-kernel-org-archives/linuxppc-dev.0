Message-ID: <3E65862E.9060606@tataelxsi.co.in>
Date: Wed, 05 Mar 2003 10:37:58 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: Vladimir Gurevich <vag@paulidav.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem in ppc-linux-gcc cross compiler.
References: <3E64DC21.4060802@tataelxsi.co.in> <3E64EA95.7050405@paulidav.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings Mr. Vladimir Gurevich,
Thank you very much. I came across these lines in the info page, but I
could not understand the meaning, which is pretty clear now.
It works.
Thanks a lot,
have a great day,
Om.

Vladimir Gurevich wrote:
> Hello,
>
> You should change the line
>
>>              warning, __FILE__, __LINE__, __FUNCTION__, ##msg) ;\
>
> to
>
>>              warning, __FILE__, __LINE__, __FUNCTION__ , ##msg) ;\
>
>
> This space (after __FUNCTION__) will do the trick.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
