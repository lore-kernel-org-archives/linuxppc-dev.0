Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id E65A4DE43D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 00:52:02 +1000 (EST)
Message-ID: <487CB991.9000301@scram.de>
Date: Tue, 15 Jul 2008 16:52:01 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>	<487C7F9A.7030201@scram.de>	<9e4733910807150640x52cca982jf4f1ccfe7fd506cf@mail.gmail.com>
	<20080715160510.0f57dd0e@hyperion.delvare>
In-Reply-To: <20080715160510.0f57dd0e@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

> Eeeek. The patch you mention here is only the conversion of ONE driver.
> It is absolutely not relevant as to what the general rule is.

Sorry, i must have misunderstood you then.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=af294867a52bf718df835a688e8c786d550bee26#patch9
is the same, my original patch listed all four supported chips in there
(saa7126, saa7127, saa7128 and saa7129) while only one made it into the driver...

> Jochen, I am very surprised that you dare drawing conclusions based on
> one random patch of mine. And I am unhappy that you even claim that I
> took some decision when I definitely did not.

Maybe I draw wrong conclusions from the discussion with Jon Smirl then.

> I can't comment on the specific issue at hand as I am not familiar with
> it, but overall Jon appears to be right. Listing individual chips in
> id_table is the standard way to go. That's even the very reason why we
> decided to add this id_table to i2c_driver, instead of matching on the
> driver name as we were doing before.

I definitely agree here.

Thanks,
Jochen
