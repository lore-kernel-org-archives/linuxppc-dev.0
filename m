Message-ID: <3F261115.7090107@intracom.gr>
Date: Tue, 29 Jul 2003 09:15:49 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Adam Kaczynski <kaczor@dgt-lab.com.pl>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Sanjay Kumar <skumar@giga-stream.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: m8260_cpm_dpfree( )
References: <FKEJLMJFECLAHOKCGJFPKEFGCBAA.skumar@giga-stream.de> <1059403782.2835.193.camel@zambia.cambridgebroadband.com> <3F2583F8.9060300@dgt-lab.com.pl>
In-Reply-To: <3F2583F8.9060300@dgt-lab.com.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adam Kaczynski wrote:

>
> Alex Zeffertt wrote:
>
>> Sanjay,
>>
>>> 1. where can I get m8260_cpm_dpfree() function implementation ?
>>
>> You could try porting the dpfree function in
>> arch/ppc/8xx_io/commproc.c.  However, this function should only really
>> be necessary if you wish to rmmod the driver.
>>
>
> I had the same problem last year when I was working with the simple ATM
> driver
> (http://www.dgt-lab.com.pl/Serwis/ATMdrv8260.tar.gz )
> and I decided to make a kind of not very nice looking work-around -
> simply to grab and later free the block of memory I needed from the top.
>
> This feature was important for us to debug the driver since I was able
> to load, test and later rmmod the driver. However this work-around would
> work only if the driver is loaded as the last one (from the drivers
> using dp_mem).
>
> I think that there is no reason to implement any more robust allocator
> for dp memory since it is used only for very special purposes, allocated
>  only during drivers initialization and because this resource is so
> limited that any normal allocation mechanism (with a pool of memory
> blocks) would be inefficient.
>
> Regards,
> Adam
>
>
>
>
>
Hi

I just want to point out that I have posted a solution to that problem
some time
ago for the 8xx.

Try searching the list for the patches, they implement a proper
dpalloc/dpfree
with storage management.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
