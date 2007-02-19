Return-Path: <jimix@watson.ibm.com>
In-Reply-To: <1171914157.18571.38.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
	<934E7F45-153D-4558-A774-FA5B6AB69E3C@watson.ibm.com>
	<1171914157.18571.38.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <275B5FDA-C250-4506-B79A-9F99107BF06C@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
Date: Mon, 19 Feb 2007 14:57:37 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	"Hollis R. Blanchard" <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2007, at 2:42 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2007-02-19 at 08:23 -0500, Jimi Xenidis wrote:
>> Hey Ben,
>> is it your intention to eventually support "/memory@x/
>> ibm,expected#pages" and will these rules effect the kernel's  
>> linear map?
>> My interest is with hypervisors that would like to restrict certain
>> LMBs to 4k so we can do our nasty memory tricks, but still have most
>> of the memory use large pages.
>
> The slices mecanism is strictly a mecanism for dealing with segment
> constraints on userland VMA layout, so I don't think it will have any
> impact either negative or positive on you.
>
> Limiting physical memory to different page sizes is a whole different
> problem that I haven't though about (damn, that would be hard).

Damn, I know, I was hoping you'd be taking care of it. :)

-JX
