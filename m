Return-Path: <ricardo.ribalda@gmail.com>
Received: from mail-fx0-f174.google.com (mail-fx0-f174.google.com
	[209.85.220.174]) by ozlabs.org (Postfix) with ESMTP id 16AB5DE012
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:59:24 +1000 (EST)
Received: by fxm22 with SMTP id 22so153835fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 10:59:23 -0700 (PDT)
MIME-Version: 1.0
Sender: ricardo.ribalda@gmail.com
In-Reply-To: <20090422171030.GH14906@codiert.org>
References: <874owhoxce.fsf@macbook.be.48ers.dk>
	<1240415535-10939-1-git-send-email-ricardo.ribalda@uam.es>
	<20090422171030.GH14906@codiert.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Date: Wed, 22 Apr 2009 19:59:08 +0200
Message-ID: <aa76a2be0904221059h59f3bea5w18f9a7f40c3e9551@mail.gmail.com>
Subject: Re: ofpart: Partitions at same address cannot have the same name
To: Benjamin Krill <ben@codiert.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David.Woodhouse@intel.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Benjamin

> Hi Recardo,
>
> I would suggest to do:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strcmp(partname, "partition") <=3D 0) =
{

Anything alfabetically higher than partition (like "zzzzz" will pass
the test :S)

Regards



>
> cheers
> =A0ben
>
>



--=20
Ricardo Ribalda
http://www.eps.uam.es/~rribalda/
