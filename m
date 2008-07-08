Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by ozlabs.org (Postfix) with ESMTP id EDD3CDDF42
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:47:14 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so651135hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 07:47:12 -0700 (PDT)
Message-ID: <fa686aa40807080747u3e1f4f57of1a2cddc67b446b9@mail.gmail.com>
Date: Tue, 8 Jul 2008 08:47:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: While(1) in kernel space
In-Reply-To: <200807081645.31807.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
	<fa686aa40807080719r4b7b01f7n7863fe1456a3e64@mail.gmail.com>
	<200807081645.31807.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paolo Doz <paolo.doz@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 8, 2008 at 8:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 July 2008, Grant Likely wrote:
>
>>
>> You can use a kernel thread.
>>
>> I'm not sure how accurate this is, but here is some information about them:
>>
>> http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread
>
> Not accurate at all. New code should use kthread_create, as documented in
>
> http://lwn.net/Articles/65178/

Teach me to blindly use google.  Thanks Arnd.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
