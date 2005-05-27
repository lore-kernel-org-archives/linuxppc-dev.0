Return-Path: <gjalt007@chello.nl>
Received: from amsfep13-int.chello.nl (amsfep13-int.chello.nl [213.46.243.23])
	by ozlabs.org (Postfix) with ESMTP id 54D61679F3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 21:59:57 +1000 (EST)
Received: from [192.168.1.10] (really [80.57.11.99]) by amsfep13-int.chello.nl
	(InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
	id <20050527115943.TYHB1736.amsfep13-int.chello.nl@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Fri, 27 May 2005 13:59:43 +0200
Message-ID: <42970B74.1060602@chello.nl>
Date: Fri, 27 May 2005 13:58:44 +0200
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



Toolchain used:   ELDK 2.0
target processor: mpc862
RAM:                64 Mbyte
Kernel:               2.4.20, extended with ATM/UTOPIA
init:                  /sbin/init -> /bin/busybox


(using a static linked busybox: activating a sh (=busybox)  
::sysinit:/bin/sh)
sh: /lib/ld.so.1          (note: /lib/ld.so.1 is a link to 
/lib/ld.so.2.5.5, part of the ELDK 2.0 )
< help page of ld.so.1>
sh: /lib/ld.so.1 --verify /bin/xxx (or just any dynamic linked executable)
<here the system has crahed>

or
sh: /bin/xxx
<here the system has crashed>

I have tried to step through the dynamic linking, but did not succeed 
til after the creation of a thread.
With a dynamic linked busybox the system stops after a message such as
"freeing xxx kbytes" (I don't know the actual number by head)
When init is then called, which is a part of the busybox which is dyn. 
liked, it crashes.


Greetings,
  Theo
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
