Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id 19FBEDE012
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:56:56 +1000 (EST)
Received: by fxm22 with SMTP id 22so151181fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 10:56:54 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <49EF5391.9050404@freescale.com>
References: <874owhoxce.fsf@macbook.be.48ers.dk>
	<20090422171030.GH14906@codiert.org>
	<49EF5391.9050404@freescale.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Wed, 22 Apr 2009 19:56:39 +0200
Message-ID: <aa76a2be0904221056v7c7357abk52e9b31bb3f7b143@mail.gmail.com>
Subject: Re: ofpart: Partitions at same address cannot have the same name
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David.Woodhouse@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott

> Perhaps "compatible" should be used instead?

What do you mean?

if (strcmp(partname, "partition") || strcmp(partname, "compatible") )

I can't see the advantages.


>
>> Hi Recardo,
>>
>> I would suggest to do:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strcmp(partname, "partition") <=3D 0)=
 {
>
> Check whether it sorts alphabetically before "partition"? =A0Why?
>
> -Scott
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
