Message-ID: <XFMail.20040521123444.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1085097417.9801.5.camel@gaston>
Date: Fri, 21 May 2004 12:34:44 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SMP kernels on single processor machines
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Lee Braiden <lee_b@member.fsf.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 20-May-2004 Benjamin Herrenschmidt wrote:
>
> On Thu, 2004-05-20 at 21:48, Lee Braiden wrote:
>
>> But I quit doing that at some point, after someone (authoritative, but I
>> can't remember the details) pointed out that it added complexity,
>> debugging issues, etc.  Given that I *already* have problems with PPC
>> kernels -- latency/lockups, (preempting?), alsa sound, video res, etc.,
>> I personally wouldn't go near this until I'm fairly confident that the
>> other stuff is solid in its own right.
>>
>> But then, I'm just a luser, not a kernel maintainer ;D
>
> Yah, well... CONFIG_PREEMPT gives you all the problems of SMP without
> any benefit so .... :)


2.6.6 has the CONFIG_PREEMPT option so I thought it was stable.
Isn't it ?  What are the known problem ?  Is only preempt+smp
known to have problems ?


--
Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
