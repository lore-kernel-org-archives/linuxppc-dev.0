Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 83728DE1F3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:44:47 +1000 (EST)
Message-ID: <487C7F9A.7030201@scram.de>
Date: Tue, 15 Jul 2008 12:44:42 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
In-Reply-To: <20080714175437.GA5230@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> Since no sane driver will ever match specific devices, what we want is
> to select most generic option (last). Then driver may call
> of_device_is_compatible() if it is really interested in details.

My original intention was to have alias entries for specific devices in the
i2c device drivers. Later, Jean decided to only have the most generic names
in there (like in http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;f=drivers/media/video/tvaudio.c;h=c77914d99d15c5972c94e9763a08b5789098e90a;hp=6f9945b04e1f2bcd676f0ed8dc910994b29ed300;hb=ae429083efe996ca2c569c44fd6fea440676dc33;hpb=60b129d7bfa3e20450816983bd52c49bb0bc1c21)
So your patch is correct.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Jochen Friedrich <jochen@scram.de>

Thanks,
Jochen
