Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 09FD867E7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 18:49:56 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so104823wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Aug 2005 01:49:55 -0700 (PDT)
Message-ID: <9b7ca65705080301497740d901@mail.gmail.com>
Date: Wed, 3 Aug 2005 17:49:55 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Rupesh S <rupeshs@myw.ltindia.com>
In-Reply-To: <s2f08948.038@EMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <s2f08948.038@EMAIL>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Issue with running depmod after cross compiling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rupesh,

I've tried it with module-init-tools version 3.2-pre8 (since it was
latest), it works like a charm. Thanks.


On 8/3/05, Rupesh S <rupeshs@myw.ltindia.com> wrote:
> Daniel,
>=20
> Assuming your kernel is 2.6 based, you might want to try module-init-tool=
s version 3.2-pre7. Also, it would be better to have the existing depmod re=
named as depmod.old. This is for the new depmod to use in case it fails to =
execute.
>=20
> --
> Rupesh S
>=20
> >>> Daniel Ann <ktdann@gmail.com> 08/03/05 06:57AM >>>
> Hey folks,
>=20
> For certain, I understand why running make module_install fails if I
> run it after cross compiling the kernel+module.
> What I'm doing now is, I've just commented out the bit in Makefile
> (where it exec's depmod), and everythings cool.
>=20
> BUT, problem with this method is, I get none of the module.dep and
> many related files for auto loading of module.
>=20
> What would be considered reasonable if I was to solve this ?
>=20
> Thanks for your thought on this in advance.
>=20
> --
> Daniel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20


--=20
Daniel
