Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B49C7DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:18:55 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l1E5IoSr017308
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 14:18:50 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l1E5IpEF018053
	for linuxppc-dev@ozlabs.org; Wed, 14 Feb 2007 14:18:51 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l1E5IotK007373
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 14:18:50 +0900 (JST)
Message-Id: <200702140518.l1E5IoxB010897@toshiba.co.jp>
MIME-Version: 1.0
Date: Wed, 14 Feb 2007 14:19:54 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: (Your message of "Fri, 26 Jan 2007 02:46:21 -0500")
	<45B9B1CD.4040600@garzik.org>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45B9B1CD.4040600@garzik.org>
Subject: Re: [PATCHSET] libata: PATA driver
	for Celleb
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Jeff-san.

>Jeff Garzik wrote:
>> This patchset consists of
>> [1] add another IRQ calls (core and headers)
>> [2] add another IRQ calls (libata drivers)
>> [3] PATA driver for Celleb
>> 
>> And patch[3] depends on patch[1,2].
>> 
>> This patchset is based on the Tejun's "devres" git tree, which is
>> available at the followin URL.
>
>Everything looks great, thanks!
>
>I'll apply this patchset immediately after applying Tejun's devres patchset.
>

Thank you for applying some parts of my patches (patch[1,2]).
But it is my goal that this Celleb patch (patch[3]) is merged into your git tree.
What's the status of this patch?

2.6.20 has been released and (I think) it is the time of merge-window
for 2.6.21. I want this patch to be merged at this time.
Please tell me if there are anything I should do.


Best regards,
Akira Iguchi
