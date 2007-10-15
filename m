Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C0B57DDEBD
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 09:36:43 +1000 (EST)
To: "S. Fricke" <silvio.fricke@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: can and mpc5200b
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Oct 2007 15:32:33 +0200."
	<20071015133233.GB4859@sfrouter>
Date: Tue, 16 Oct 2007 01:36:42 +0200
Sender: wd@denx.de
Message-Id: <20071015233642.04D1F247BB@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20071015133233.GB4859@sfrouter> you wrote:
> 
> what is the reasonable can-driver for a mpc5200b?

socket-can.

> I have seen for the peak-3.17 driver a port for the mpc5200 from denx on their
> website, but with kernel 2.6.23 I dont have a chance to use this?

No, but socket-can is part of our kernel tree already, and of the
kernel.org tree in 2.6.24

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The human mind ordinarily operates at only ten percent of its capaci-
ty - the rest is overhead for the operating system.
