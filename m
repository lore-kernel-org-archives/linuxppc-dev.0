Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 0804D67A76
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 11:09:48 +1100 (EST)
Message-ID: <41F04849.70506@mvista.com>
Date: Thu, 20 Jan 2005 17:09:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com> <1106259956.18397.10.camel@gaston>	
	<41F0449C.5020603@mvista.com> <1106265672.5387.14.camel@gaston>
In-Reply-To: <1106265672.5387.14.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Thu, 2005-01-20 at 16:54 -0700, Mark A. Greer wrote:
>
>  
>
>>Choosing a) give you more flexibility within PPC but is PPC only; 
>>choosing b) is generic but assumes its the only rtc chip that will be 
>>used by whatever kernel binary its put in.
>>
>>I chose b) and to reuse the genrtc code.  In a sane world, reusing code 
>>is considered a good thing...
>>
>>Its obvious that you and Tom prefer a).  That's fine but if I switch to 
>>a), I know the first comment I'll get when I post the driver to lmkl 
>>will be, "Why would you make this ppc-specific when you could have made 
>>it generic?"  Will you and Tom then defend that decision for me?
>>
>>Also, this is not board-specific as you and Tom have tried to suggest.  
>>Assuming I change the #ifdef in rtc.h to remove the option as I think 
>>Tom and I are agreeing upon, you select the i2c algo/adapter, the 
>>i2c/rtc client and its there.  Where are the "gross hacks for every board"?
>>    
>>
>
>Because it makes things like CONFIG_PPC_MULTIPLATFORM impossible, which
>means you end up with a CONFIG_* mess.
>

/me feels the anger...   :)

>
>I consider that more important than re-using code.
>

Okay, it shall be so.

>
>In any case, as I wrote, the proper solution is to update genrtc to
>define rtc_ops so that you get both a) and b), it shouldn't be hard to
>update the archs using it.
>  
>

Yes but as I wrote, I don't have time right now.

Mark
