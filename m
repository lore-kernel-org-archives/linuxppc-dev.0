Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A6E1067C4A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 10:34:43 +1100 (EST)
To: "Goel, Mudit (Mudit)" <muditg@lucent.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux Kernel 2.6 on Artesyn Katana Board (3750) with IBM 750F X
	PP C
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Nov 2006 16:16:35 +0530."
	<3BE48DD0EC7D3948BC183931D9150C210BBB0CA1@ii0015exch001u.iprc.lucent.com>
Date: Tue, 07 Nov 2006 00:34:40 +0100
Sender: wd@denx.de
Message-Id: <20061106233440.A0351353A5F@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3BE48DD0EC7D3948BC183931D9150C210BBB0CA1@ii0015exch001u.iprc.lucent.com> you wrote:
>   After making an uIamge and using bootm here is the o/p. I have tried using
> DHCP/ RARP options also
>   but I dont see any requests coming onto the host machine where the server
> is runnig. Is there something
>   incorrect in the configuration that I have. 

Probably a bug or configuration problem in your Linux kernel and/or
your toolchain.

> Linux version 2.6.10_mvlcge401-katana (root@hdrlin03) (gcc version 3.4.3
> (MontaVista 3.4.3-25.0.41.0501420 2005-09-07)) #32 Mon Nov 6 16:03:17 IST 2006

Since this is a MVL source tree and tools, you probably want  to  ask
MV support...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never call a man a fool.  Borrow from him.
