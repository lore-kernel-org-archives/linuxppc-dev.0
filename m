Return-Path: <gjalt007@chello.nl>
Received: from amsfep15-int.chello.nl (amsfep15-int.chello.nl [213.46.243.27])
	by ozlabs.org (Postfix) with ESMTP id 0AA95679F1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 06:30:48 +1000 (EST)
Received: from [192.168.1.10] (really [80.57.11.99]) by amsfep15-int.chello.nl
	(InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
	id <20050531203042.SJMU6651.amsfep15-int.chello.nl@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 May 2005 22:30:42 +0200
Message-ID: <429CC929.5060405@chello.nl>
Date: Tue, 31 May 2005 22:29:29 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <429639D5.20609@chello.nl>
	<E6CEFEB5-1F03-45DA-8BA3-C1F1511950EA@aimsys.nl>
In-Reply-To: <E6CEFEB5-1F03-45DA-8BA3-C1F1511950EA@aimsys.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Dynamic libraries do not work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I 've found the problem, the ramdisk used contained executables as well 
as dyn. libs from the mpc8260 instead of the mpc862.
I don't know why the whole system came to a halt without any message but 
replacing the dyn. libs and executables with the correct ones solved the 
problem of crashing.

Many thanks for your responses,
   Theo.



Jaap-Jan Boor schreef:

> Theo,
>
> What type of processor are you using? 8xx?
> Did you build a tool-chain yourself and are
> you perhaps using floating point?
>
> Jaap-Jan
>
> On 26-mei-2005, at 23:04, Theo Gjaltema wrote:
>
>> Hello,
>>
>> I have a linux 2.4.20 kernel running, but the files in the ramdisk  
>> fail to execute if they are dynamically build.
>> The whole system stops (debuggers shows that it crashed while in an  
>> erea where no flash/ram is present.
>> Anyone an idea?
>> There is nog difference between the use of a ramdisk or an nfs  
>> mounted root filesystem.
>>
>> Greetings,
>>    Theo.
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
> ____
> J.G.J. Boor                       Anton Philipsweg 1
> Software Engineer                 1223 KZ Hilversum
> AimSys bv                         tel. +31 35 689 1941
> Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
>
>
>
