Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 77633DE0C8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 19:44:47 +1000 (EST)
Message-ID: <4885AC94.7050501@coritel.it>
Date: Tue, 22 Jul 2008 11:47:00 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: how to allocate 9MB of memory in kernel ?
References: <18503022.post@talk.nabble.com>
	<200807181739.10268.arnd@arndb.de>	<18582612.post@talk.nabble.com>
	<200807221131.32556.arnd@arndb.de>
In-Reply-To: <200807221131.32556.arnd@arndb.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Tuesday 22 July 2008, Misbah khan wrote:
>> I am getting kernel panic while trying these as suggested by you ,the
>> following points will elaborate my concern :-
>> i am allocating memory using vmalloc and remaping to the SDRAM area as :-
>>
>> buf_area = vmalloc(sizeof(circularbuffer_S));
>>         if(!buf_area)
>>         {
>>                 printk(KERN_ALERT"vmalloc failed \n");
>>                 return -1;
>>         }
>>
>>         buf_area = (circularbuffer_S *)ioremap(7700000,900000);
>>         if(!buf_area)
>>         {
>>                 printk(KERN_ALERT"ioremap failed \n");
>>                 return -1;
>>         }

Misbah I suggest you, before to write in a Linux mailing list, to read 
Understanding the Linux kernel, Linux device drivers, Understanding the 
Linux virtual memory manager and so on, to study them very well, to 
think well about your problem and then ask for help in a mailing list.

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
