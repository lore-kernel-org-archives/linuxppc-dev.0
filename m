Message-ID: <40486783.7010703@imc-berlin.de>
Date: Fri, 05 Mar 2004 12:41:55 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: uncached user space mapping with mmap() ???
References: <40473464.8010203@imc-berlin.de> <404837D3.3060609@imc-berlin.de> <40486600.9090304@jonmasters.org>
In-Reply-To: <40486600.9090304@jonmasters.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Masters wrote:

> | Is it always better to map only the small part I am going to use?
>
> Of course it is always best to map only the small range that you are
> going to use and there will not necessarily be only one TLB mapping (I
> am here referring to your comments on ARM Linux Kernel List) etc. etc.
> However here especially I am inclined to repeat what they said on the
> other list - these figures are so close that they might differ for other
> reasons and so on. Did you repeat this in a controlled way many times?

Yes. The thruput is calculated after repeating the loop 1000 times
(Retries = 1000).

> You will need to answer the questions Russell King posted in order for
> us to work through this and figure out where the difference lies.
I am just about to do it.


--
Steven Scholz

imc Measurement & Control               imc Meﬂsysteme GmbH
Voltastr. 5                             Voltastr. 5
13355 Berlin                            13355 Berlin
Germany                                 Deutschland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
