Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050811201821.GY3187@smtp.west.cox.net>
References: <20050811201821.GY3187@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DE2CC80C-91A2-4860-B452-6AD171F3588A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 11 Aug 2005 18:07:03 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Gill Becky-BGILL <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 11, 2005, at 3:18 PM, Tom Rini wrote:

> On Thu, Aug 11, 2005 at 03:13:30PM -0500, Kumar Gala wrote:
>
>>
>> On Aug 11, 2005, at 2:59 PM, Tom Rini wrote:
>>
>>
>>> On Wed, Aug 10, 2005 at 11:45:10AM -0500, Becky Bruce wrote:
>>>
>>> [snip]
>>>
> [snip]
>
>>>>        83xx/ (may collapse into classic 32 at some point)
>>>>        86xx/ (may collapse into classic 32 at some point)
>>>>        pq2/ (may collapse into classic 32 at some point)
>>>>
>>>>
>>>
>>> PQ2 is the marketing name for 82xx, lets just call it 82xx.
>>>
>>
>> The problem is that PQ2 describes a subset of 82xx (it nots
>> 8240/8241/8245).
>>
>
> All the more reason imho to stick all 82xx stuff under '82xx', rather
> than classic32 or 'pq2'.

I think this causes confusion.  the reason we suggested pq2 and  
classic32 was to handle things like sandpoint.  Sandpoint would live  
in classic32.  The confusion partial comes from the fact that we can  
run 8240/1/5 on a Sandpoint.  The thinking was everything that was  
6xx/7xx/74xx + things like 8240/1/5 which can be thought of as 603 +  
10x bridge would be classic32.

If it was 82xx w/o a CPM it went into classic32.  If it was a 82xx w/ 
CPM it went into pq2.  The idea being that we might be able to build  
kernels in either directory that supported a large number of boards  
with one image.

Anyways, that was the thought process to try and keep things sane.   
(Which it may not ;)

- kumar
