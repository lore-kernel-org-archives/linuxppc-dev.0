Return-Path: <gjalt007@chello.nl>
Received: from amsfep13-int.chello.nl (amsfep13-int.chello.nl [213.46.243.23])
	by ozlabs.org (Postfix) with ESMTP id 87FB967C3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 07:33:03 +1000 (EST)
Message-ID: <42D58861.5040900@chello.nl>
Date: Wed, 13 Jul 2005 23:32:17 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050713203204.7F711353A37@atlas.denx.de>
In-Reply-To: <20050713203204.7F711353A37@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk schreef:

>In message <42D5361B.2070402@chello.nl> you wrote:
>  
>
>>It appeard that on my mpc862 target I had also this problem. I am using
>>ELDK3.1.1 which includes a 2.4.25 kernel.
>>    
>>
>
>No, most definitely not.
>
>  
>
I don't understand this, on
/pub/Linux/distributions/eldk/3.1.1/ppc-linux-x86/distribution/common
there are the sources of a 2.4.25 kernel.

>>    Large application (20MB c++, mostly shared-libs) crashes (sigseg) at
>>startup BEFORE main() is called.
>>    Attempts to debug the application also fail: the debugger crashes
>>also (sigseg).
>>    
>>
>
>I bet that this is a FAQ. Your SDRAM initialization is broken.
>  
>
This was one of my guesses also. Since this is beyond my knowledge, I 
had the parametes initialisation parameters compared to an other 
platform which did not had the problems (rtos based), the same 
parameters were used. I did not investigate it any further.

>  
>
>>I didn't change the C-lib, I took the 2.4.30/arch/ppc/kernel/head_8xx.S
>>file and copied this over the 2.4.25 head_8xx.S file.
>>In the 2.4.30 version there is a piece of code mentioning the dcbX
>>instruction problems.
>>    
>>
>
>And did this fix the problem completely? I would be a bit surprised.
>
>  
>
No problem since.

>>This driver causes the CPM sometimes to hang when performing a memset,
>>can this be caused by the same problem?
>>    
>>
>
>Yes. When your SDRAM init is broken, strange things will happen.
>
>  
>
I'll try the kernel with the original atm/utopia to see what happens.

>Best regards,
>
>Wolfgang Denk
>
>  
>
Thanks,
    Theo Gjaltema.
