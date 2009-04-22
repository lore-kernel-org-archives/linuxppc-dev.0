Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3CF91DE05A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:34:04 +1000 (EST)
Date: Wed, 22 Apr 2009 20:33:54 +0200
From: Benjamin Krill <ben@codiert.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: ofpart: Partitions at same address cannot have the same name
Message-ID: <20090422183353.GI14906@codiert.org>
References: <874owhoxce.fsf@macbook.be.48ers.dk>
	<1240415535-10939-1-git-send-email-ricardo.ribalda@uam.es>
	<20090422171030.GH14906@codiert.org>
	<aa76a2be0904221059h59f3bea5w18f9a7f40c3e9551@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <aa76a2be0904221059h59f3bea5w18f9a7f40c3e9551@mail.gmail.com>
Cc: David.Woodhouse@intel.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Ricardo Ribalda Delgado | 2009-04-22 19:59:08 [+0200]:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(partna=
me, "partition") <=3D 0) {
>
>Anything alfabetically higher than partition (like "zzzzz" will pass
>the test :S)

You are totally right!

cheers
 ben
