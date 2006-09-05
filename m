Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6092C67B86
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 01:39:28 +1000 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot-Users] OT: Re: Status of OF in TQM8540 and
	linux-2.6.17.11
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Sep 2006 19:06:08 +0400."
	<20060905190608.082331bc@vitb.ru.mvista.com>
Date: Tue, 05 Sep 2006 17:39:25 +0200
Sender: wd@denx.de
Message-Id: <20060905153925.F1384353A15@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20060905190608.082331bc@vitb.ru.mvista.com> you wrote:
>
> Clemens Koller <clemens.koller@anagramm.de> wrote:
...
> > According to TQC, the latest "working" kernel was a 2.6.15-git from your
> > (denx) tree. I get the details from Mr. Becher@TQC and see how far I can get.

[TQ provides obsolete information.]


> The upper defines need to reside in the board-specific code for tqm as well as for other boards
> utilizing such scheme (see platforms/85xx/mpc85xx_ads_common.h for instance).

Thanks for pointing out.

Clemens, plese try again (commit id cd4ebbc9b95434977e5f182b9a22d7d1de0748ce)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Where shall I begin, please your Majesty?" he asked. "Begin  at  the
beginning,"  the  King said, gravely, "and go on till you come to the
end: then stop."    - Alice's Adventures in Wonderland, Lewis Carroll
