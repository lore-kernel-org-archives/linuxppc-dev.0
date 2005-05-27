Return-Path: <gjalt007@chello.nl>
Received: from amsfep18-int.chello.nl (amsfep18-int.chello.nl [213.46.243.13])
	by ozlabs.org (Postfix) with ESMTP id 2715B67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 15:37:04 +1000 (EST)
Received: from [192.168.1.10] (really [80.57.11.99]) by amsfep18-int.chello.nl
	(InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
	id <20050527053658.LOG1513.amsfep18-int.chello.nl@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Fri, 27 May 2005 07:36:58 +0200
Message-ID: <4296B1D2.5090409@chello.nl>
Date: Fri, 27 May 2005 07:36:18 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <429639D5.20609@chello.nl>
	<528646bc05052615304d896b94@mail.gmail.com>
In-Reply-To: <528646bc05052615304d896b94@mail.gmail.com>
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

Grant Likely schreef:

>On 5/26/05, Theo Gjaltema <gjalt007@chello.nl> wrote:
>  
>
>>Hello,
>>
>>I have a linux 2.4.20 kernel running, but the files in the ramdisk fail
>>to execute if they are dynamically build.
>>The whole system stops (debuggers shows that it crashed while in an erea
>>where no flash/ram is present.
>>Anyone an idea?
>>There is nog difference between the use of a ramdisk or an nfs mounted
>>root filesystem.
>>
>>    
>>
>More data please;  Make sure you attach actual output when asking for help.
>
>  
>
You are right, this gives too little info. Since the system stops 
without giving any data, I don't know what to attach
maybe:
RAM: 64 Mbyte

(using a static linked busybox: activating a sh (=busybox) b 
::sysinit:/bin/sh)
sh: /lib/ld.so.1
< help page of ld.so.1>
sh: /lib/ld.so.1 --verify /bin/xxx (or just any dynamic linked library)
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
