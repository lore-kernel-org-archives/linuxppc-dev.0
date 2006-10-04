Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E6B267CB3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 18:35:17 +1000 (EST)
Message-ID: <4523723B.5030809@gmail.com>
Date: Wed, 04 Oct 2006 09:35:07 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: booting 2.6 kernel on ML403
References: <BAY110-F1626C56882856AE74835E5B21D0@phx.gbl>
In-Reply-To: <BAY110-F1626C56882856AE74835E5B21D0@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Ming Liu wrote:
> Hi,
>
>> [ 3.093694] TCP bic registered
>> [ 3.129458] NET: Registered protocol family 8
>> [ 3.181412] NET: Registered protocol family 20
>> [ 3.236744] VFS: Cannot open root device "xsa2" or unknown-block(0,0)
>> [ 3.313092] Please append a correct "root=" boot option
>
> It looks that some errors still exist in the parameters you passed to
> "root=". Please double check it, or post it in the maillist for deep
> analysis.
> Regards
> Ming
>
> _________________________________________________________________
> 享用世界上最大的电子邮件系统— MSN Hotmail。 http://www.hotmail.com
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
Hi Ming,
IIRC, you are or were using the TEMAC driver along with my System Ace
driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for
you? I ask this because Pradeep is having some problems using it (see
Problem 2 in his email). Could you please update on this?

Thanks,
-Ameet
