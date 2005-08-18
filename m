Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3A38168050
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Aug 2005 02:25:29 +1000 (EST)
In-Reply-To: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
References: <E1E5KpP-0004dy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A4C8B92D-B390-4BF8-A6D5-106ACBD0E716@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 18 Aug 2005 11:25:19 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, zach@vmware.com, linux-kernel@vger.kernel.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org,
	"Gala Kumar K.-galak" <galak@freescale.com>, davem@davemloft.net
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2005, at 5:07 AM, Miklos Szeredi wrote:

>>> They are provided by _one_ kernel, not necessarily the running
>>>
> kernel.
>
>>
>> No, they're provided by packages like glibc-kernheaders or similar
>> that are maintained separately.
>>
>
> Yes.  And "maintenance" I presume means "copy" the kernel headers and
> do some cleanup to be compliant to the relevant standards (which the
> kernel maintainers couldn't be bothered to do).
>
>
>> They're split from the kernel headers and we don't need to keep
>> obsolete junk around.
>>
>
> I agree about obsolete junk.
>
> However statements like "No kernel headers can be included by userland
> anymore" can be slightly misleading.

So after all of this its not clear to me if its acceptable to kill  
all users of <asm/segment.h> in the kernel and to move code that  
exists in <asm/segment.h> to <asm/uaccess.h> for arch's that need it.

- kumar
