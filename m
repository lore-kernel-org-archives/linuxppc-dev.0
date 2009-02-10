Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 30975DDDAE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 10:46:10 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so68719and.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 15:46:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1234309106.8323.11.camel@localhost>
References: <4990EF8B.7060203@us.ibm.com>
	<3ae3aa420902100914t572da49chf22b5fdda644033f@mail.gmail.com>
	<1234309106.8323.11.camel@localhost>
Date: Tue, 10 Feb 2009 17:46:07 -0600
Message-ID: <3ae3aa420902101546t4a494200ybcef9f74a7a7f579@mail.gmail.com>
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
From: Linas Vepstas <linasvepstas@gmail.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/2/10 Michael Ellerman <michael@ellerman.id.au>:
> On Tue, 2009-02-10 at 11:14 -0600, Linas Vepstas wrote:
>> On a somewhat-related note: there was an issue (I forget
>> the details) where the kernel needed to shadow some sort
>> of MSI state so that it could be correctly, um, kept-track-of,
>> after an EEH reset (it didn't need to be restored, because
>> firmware did this(?)).  After some digging around and
>> discussion, we concluded that some generic PPC MSI
>> code needed to be altered to track this state, and/or
>> the main kernel MSI code needed to be changed to
>> (not?) track this state.  Mike Ellerman seemed to best
>> grasp this area ... was this ever fixed?
>>
>> Or perhaps this is an alternate fix for that bug? It may
>> well have been that calling the MSI disable triggered
>> the problem, I don't remember now.
>
> I'm pretty sure you're referring to this patch, which you acked :)
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1db3e890aed3ac39cded30d6e94618bda086f7ce
>
> I don't know of anything else that fits your description?

Yes, that's the one. I wasn't sure if it ever made it in or
not, and I just wanted to make sure it wasn't what was
biting you.

--linas
