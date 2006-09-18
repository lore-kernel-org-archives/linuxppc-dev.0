Return-Path: <prakash@ipinfusion.com>
Received: from gateway.ipinfusion.com (mail.ipinfusion.com [65.223.109.2])
	by ozlabs.org (Postfix) with ESMTP id 8D1C767B22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 04:27:04 +1000 (EST)
Message-ID: <450EE5C3.3000000@ipinfusion.com>
Date: Mon, 18 Sep 2006 11:30:27 -0700
From: Prakash Jain <prakash@ipinfusion.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Kernel module insertion issue with kernel 2.6.15
References: <450B058B.6060806@ipinfusion.com>
	<200609170126.26557.arnd@arndb.de>
In-Reply-To: <200609170126.26557.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I suspected it to be a kernel level issue (in insmod) that's why I 
posted it for suggestion if someone else also has encountered it while 
porting module from 2.4 to 2.6 kernel. I expected mailing list is to be 
for any technical questions related to ppc-linux-kernel. I have to check 
the GPL status of the module as it is a third party code (I already 
mentioned it in my email).
Thanks for your words any way..
Prakash

Arnd Bergmann wrote:

>On Friday 15 September 2006 21:56, Prakash Jain wrote:
>  
>
>>Can someone give few pointers on what could be the reasons and where to 
>>look to resolve this? Will appreciate your time,
>>    
>>
>
>If you want help with this, you need to post your module source code.
>As long as people suspect you're talking about illegal or non-GPL
>code, don't expect anyone to answer technical questions.
>
>	Arnd <><
>
>
>  
>
