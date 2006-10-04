Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s20.bay0.hotmail.com (bay0-omc1-s20.bay0.hotmail.com
	[65.54.246.92]) by ozlabs.org (Postfix) with ESMTP id 2F4EF67B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 18:42:40 +1000 (EST)
Message-ID: <BAY110-F79748D36D754E6D6B2A99B21D0@phx.gbl>
In-Reply-To: <4523723B.5030809@gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: ammubhai@gmail.com
Subject: Re: booting 2.6 kernel on ML403
Date: Wed, 04 Oct 2006 08:42:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Hello Ameet,
I am using that driver very well now. There is only one problem. It seems 
that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M 
adapted. But because I want to use the Gigabit enet, I don't care that. So 
it's OK, at lease for 1Gbit/s.

So I don't think Pradeep's problem is caused by Temac. I still suspect that 
he didn't pass a right parameter to "root=", just like what I posted 
before.

Regards
Ming


>From: Ameet Patil <ammubhai@gmail.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: pradeepsampath@yahoo.com,  linuxppc-embedded@ozlabs.org
>Subject: Re: booting 2.6 kernel on ML403
>Date: Wed, 04 Oct 2006 09:35:07 +0100
>
>Ming Liu wrote:
> > Hi,
> >
> >> [ 3.093694] TCP bic registered
> >> [ 3.129458] NET: Registered protocol family 8
> >> [ 3.181412] NET: Registered protocol family 20
> >> [ 3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
> >> [ 3.313092] Please append a correct "root=" boot option
> >
> > It looks that some errors still exist in the parameters you passed to
> > "root=". Please double check it, or post it in the maillist for deep
> > analysis.
> > Regards
> > Ming
> >
> > _________________________________________________________________
> > 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com
> > 
------------------------------------------------------------------------
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>Hi Ming,
>IIRC, you are or were using the TEMAC driver along with my System Ace
>driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for
>you? I ask this because Pradeep is having some problems using it (see
>Problem 2 in his email). Could you please update on this?
>
>Thanks,
>-Ameet

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
