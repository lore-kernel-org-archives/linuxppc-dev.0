From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 7450 bugs & fixes
Date: Fri, 14 Dec 2001 10:17:36 +0100
Message-Id: <20011214091736.18195@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0112140004070.21952-100000@blues.wcg.mcgill.ca>
References: <Pine.LNX.4.33.0112140004070.21952-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Once upon a time, BenH wrote:
>> After reading the 7450 errata book, I'm now trying to figure out what
>>need to be done for our kernel to work properly on these. I'd appreciate
>>any input from other people here as some of the errata exact
>>consequences aren't that clear to me.
>
> Could this be the reason why my Dual 800 is crashing a lot? It is running
>2.4.17-pre2, PostgreSQL 7.1, Apache 1.3.20 with 1GB of RAM, 512 MB swap
>and hardly gets any work. This machine has crashed hard probably about 5
>times in the last 2 weeks and I can't find anything in the logs (not sure
>where else to look).
>
> Is anyone running this machine successfully or have the same experiences
>as me? Any info would be much appreciated.

Get a more recent kernel. I've worked around a couple of these errata
in both my rsync tree and the bitkeeper ppc kernels.

And please, don't forget to tell me if it works better ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
