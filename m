Message-ID: <3CFE5750.1010209@linuxfoundary.com>
Date: Wed, 05 Jun 2002 14:24:16 -0400
From: Dave Strout <dstrout@linuxfoundary.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basics -- what tools for Walnut?
References: <3CFE4C3A.4070604@linuxfoundary.com> <3CFE4F42.DDB1D5CE@mvista.com> <3CFE54F6.1060605@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's all good -- I didn't realize there was a newer binutils.  2.12
seems to do the trick

thanks,
dave.

Dan Malek wrote:

>
> Frank Rowand wrote:
>
>> I suspect that is a fairly old tool chain that you are using.
>
>
> In the past, the practice was to inform people when changes were made
> that required a minimum revision of tools to operate properly.
> Simply telling people "your toolchain is too old" isn't helpful.....
> What version of tools is required to build this properly?  Why
> doesn't the check in comment indicate this information when the
> change was made?
>
>> Try modifying arch/ppc/Makefile to use
>>
>>   -mcpu=403
>
>
> Or, just remove it since it doesn't perform any useful function.  On
> the newer tools, it's required to allow the assembler to not bitch about
> 4xx unique instructions, another non-useful function, IMHO.
>
> Thanks.
>
>     -- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
