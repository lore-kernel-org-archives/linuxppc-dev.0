Return-Path: <sylvain.joyeau@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 11EF0DE254
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 18:02:10 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so3009513fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jul 2008 01:02:08 -0700 (PDT)
Message-ID: <d194b8ce0807170102x4be8b7ccx33a6a09e6129a45b@mail.gmail.com>
Date: Thu, 17 Jul 2008 10:02:07 +0200
From: "Sylvain Joyeau" <sylvain.joyeau@gmail.com>
To: "Misbah khan" <misbah_khan@engineer.com>
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <18503022.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18503022.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: sjoyeau@wanadoo.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah,

Please, give some more details about your application: the answer(s)
heavily depends on the kind of memory you want to allocate: contiguous
(implied in DMA purpose) or not (for process memory sharing only).

--
sj


2008/7/17 Misbah khan <misbah_khan@engineer.com>:
>
> Hi all,
>
> I need to allocate 9 MB of memory in to the kernel space which i need to
> mmap for the application to access.
>
> I need to know what could be the best possible way of doing the same.
>
> Please share your experience in this regard .
>
> Thank you in advance
>
> ----Misbah <><
> --
> View this message in context: http://www.nabble.com/how-to-allocate-9MB-o=
f-memory-in-kernel---tp18503022p18503022.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



--=20
------------------
Sylvain JOYEAU
Freelance Engineer
Software RT-OS R&D
sylvain.joyeau@gmail.com
T=E9l: +33-(0)667 477 052
"A good idea is one side of the coin. The other side is the practical
usefulness". J. Liedke.
