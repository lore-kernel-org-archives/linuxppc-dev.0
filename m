Return-Path: <greg.weeks@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 8523B686FA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Nov 2005 06:47:59 +1100 (EST)
Message-ID: <4374F56B.8080500@timesys.com>
Date: Fri, 11 Nov 2005 14:47:55 -0500
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <331697990.25627@st.lzu.edu.cn> <437493D3.2070301@timesys.com>
	<20051111193516.GA31237@gate.ebshome.net>
In-Reply-To: <20051111193516.GA31237@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: floating point operation of ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:

>On Fri, Nov 11, 2005 at 07:51:31AM -0500, Greg Weeks wrote:
>  
>
>>lily wrote:
>>
>>    
>>
>>>hi,all:
>>>i build an embedded linux on powerpc 405ep,i need execute floating
>>>point operation,and i enable "math emulate" option in kernel, i run a
>>>while(1)loop ,in the loop there was floating point expression ,after
>>>test ,i found the while (1) exit because of the floating point
>>>computation,that is the floating point can't execute on ppc
>>>stablely.Is there someone meets the same problems ,please give me some
>>>suggestion,thanks!!!
>>>      
>>>
>>The 405ep has some errata on floating point use. 
>>    
>>
>
>Are you sure it was 405ep? There is no floating point errata for this 
>chip due to the simple reason, it doesn't support floating point in 
>hardware at all.
>
>You probably confusing it with 440ep.
>
>  
>
You're right. It was the 440ep. The 405ep BSP is using the 4xx 
toolchain. I don't think I've ever tried the math emulator on a 405.


Greg Weeks
