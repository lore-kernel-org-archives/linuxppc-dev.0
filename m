Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 2A8B9DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 22:18:11 +1100 (EST)
Message-ID: <49C37B5A.1080307@mlbassoc.com>
Date: Fri, 20 Mar 2009 05:17:46 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: dhlii@dlasys.net
Subject: Re: Xilinx cygwin linux cross recommendations ?
References: <49C2DC5D.6000701@dlasys.net>	<fa686aa40903191716wa0fa4f5r15fc9c5560468a20@mail.gmail.com>
	<49C2EA49.90907@dlasys.net>
In-Reply-To: <49C2EA49.90907@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
>     I have no experience with ELDK.
>     Have you used it ? Do you like it ?
> 
>     When I started I mostly did a roll my own environment using crosstool.
>     I would have stuck to that except I can not get uclibc and it has
> not been updated in a long time.
>     Crosstool-ng did not support the ppc last time I looked.

Look again - PowerPC is quite well supported by CrossTool-ng

>     Today I use buildroot - mostly just to build a toolchain - I have
> never been able to get it to do many of the other things it is capable of.
> 
>     I am not particularly fond (serious understatement)  of "integrated
> solve all the problems of the world" environments, they rarely work, and
> you must think inside their box.
>    
>     I would be ecstatic with just a cygwin-linux-ppc-uclibc tool chain.
> 

Why not just skip the torture (CygWin) and just run a virtual machine
on Windows [I assume you _have_ to have Windows].  Both VM-Ware and VirtualBox
handle this problem beautifully.  Then you have *Linux* for your development
environment, not some cobbled set of pieces...

> 
> Grant Likely wrote:
>> On Thu, Mar 19, 2009 at 5:59 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>>   
>>>    Does anyone have experience sugestions for building ppc/linux apps
>>> or even ppc kernels under windows.
>>>     
>> I hear rumors that there is a Windows version of ELDK.
>>
>>   
> 
> 


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
