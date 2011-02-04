Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1069AB70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Feb 2011 13:23:02 +1100 (EST)
Received: by vws20 with SMTP id 20so1171102vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Feb 2011 18:22:58 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1296774957.14077.23.camel@shaggy-w500>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230844.GG3032@yookeroo>
	<1296690839.12290.108.camel@shaggy-w500>
	<20110203050351.GK3032@yookeroo>
	<1296774957.14077.23.camel@shaggy-w500>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 3 Feb 2011 20:22:18 -0600
Message-ID: <AANLkTimbE-zNH9UCxDjNx65gNgDVqOmKk0SKShqkJ4mS@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 3, 2011 at 5:15 PM, Dave Kleikamp <shaggy@linux.vnet.ibm.com> w=
rote:

>> Bit too short, I think. =A0I'd suggest either spelling out
>> 'asymmetric-multiprocessor' or 'cooperative-partition' (a more
>> accurate term, IMO).
>
> I could be wrong, but I thought the A stands for Asynchronous, not
> Asymmetric. =A0I thought Asymmetric means that different types of tasks
> run on the secondary processors, as on the Cell. =A0Anyway, going with
> 'cooperative-partition' would avoid that confusion.

Well, if we pretend that everyone already knows what the "A" stands
for, that's not going to avoid confusion.  Some people still are going
to be wrong.  It would be great if we could settle the matter once and
for all.

I've always thought the A stood for asymmetric, since you're running
multiple cores, but each OS is not aware of the others.  It doesn't
necessarily have to be two copies of Linux.  In fact, it usually
isn't.

As for "MPC8572DS-CAMP", I've always hated that.  A specific property
that defines an AMP environment is a much better idea.

--=20
Timur Tabi
Linux kernel developer at Freescale
