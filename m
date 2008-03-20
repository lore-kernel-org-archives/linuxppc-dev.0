Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 62D62DDF3B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 11:14:48 +1100 (EST)
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: simple MPC5200B system
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Mar 2008 09:49:31 +0100."
	<47DF821B.6090600@matrix-vision.de>
Date: Thu, 20 Mar 2008 01:14:45 +0100
Sender: wd@denx.de
Message-Id: <20080320001445.C03DD24A8B@gemini.denx.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <47DF821B.6090600@matrix-vision.de> you wrote:
>
> I've pulled the latest git and built a mpc5200_simple system with a 
> minimal dts.
> There's not a single char put on the console ....

You did build your device tree with "-b 0", didn't you?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
EMACS belongs in <sys/errno.h>: Editor too big!
