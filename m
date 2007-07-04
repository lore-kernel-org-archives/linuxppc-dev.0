Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id D4687DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 15:42:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4530754pyi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jul 2007 22:42:26 -0700 (PDT)
Message-ID: <8496f91a0707032242w40c0f398s87ab5a9249c0e902@mail.gmail.com>
Date: Wed, 4 Jul 2007 09:42:26 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: "li.chunlin@zte.com.cn" <li.chunlin@zte.com.cn>
Subject: Re: about FCC of MPC8270
In-Reply-To: <OF067D5541.23C80493-ON4825730E.001766FC-4825730E.00183FCF@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4b73d43f0707030931v42aefc72x2598546e48ae87e8@mail.gmail.com>
	<OF067D5541.23C80493-ON4825730E.001766FC-4825730E.00183FCF@zte.com.cn>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

Do you use CPM_FCC_SPECIAL_BASE constant? (include/asm-ppc/cpm2.h)
In my case (8250, 8260) FCCs only works when it is set to 0x3000...


2007/7/4, li.chunlin@zte.com.cn <li.chunlin@zte.com.cn>:
>
> hello, every one
>
>    I have a board with mpc8270. And there are two ethernet interface by fcc1
> and fcc2. Now in linux kernel 2.6.14 fcc1 is ok, but fcc2 is some wrong. I
> set loopback of fcc2 or rmii. that's ok. But i set loopback in phy, it is
> wrong. But fcc2 is ok in u-boot.
>
> I take a look with oscillograph. i find that there is signal from fcc2 to
> phy and there is signal from phy to fcc2 in data pins. But fcc2 cannot
> receive data and fcc2 can send data.
>
> who know the reason? Can you tell me?
>
> thanks.
> lichunlin
>
