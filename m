Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1126223767.29803.34.camel@gaston>
References: <1126223767.29803.34.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A32A4DA9-99D6-4574-AD5D-F1C0DFC8AE75@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 20:34:52 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc: Merge tlb.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 6:56 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2005-09-08 at 16:11 -0500, Kumar Gala wrote:
>
>> Merged tlb.h between asm-ppc32 and asm-ppc64 into asm-powerpc.  Also,
>>
> fixed
>
>> a compiler warning in arch/ppc/mm/tlb.c since it was roughly related.
>>
>> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
>>
>
> Do we want to do that ?
>
> Replacing 2 different files with one split in #ifdef isn't a  
> progress...
> As I said, I think we need two subdirs for the low level stuffs  
> that is
> different, and that includes at this point all of the memory  
> management
> related stuff.

I understand, but I'm also not sure if its progress to duplicate a  
major of a file that is common.

In this case it might be better handled by having specific versions  
per "sub-arch".  I think the key is determining which files should be  
handled via sub-arch diffs and which should be handled via ifdef's in  
the file.

Some cases like ppc_asm are so similar that it seems better to have a  
single file and ifdef the specific case.

> In addition, I'd appreciate if we could avoid touching ppc64 mm  
> related
> files completely for a couple of weeks as I'm working on a fairly big
> patch that I'm really tired of having to rebase all the time ;)

Will avoid touch any other mm related headers than :)

- kumar
