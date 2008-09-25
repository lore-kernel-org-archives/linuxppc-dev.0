Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 15D0FDDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 18:51:54 +1000 (EST)
Message-ID: <48DB50E4.4050509@scram.de>
Date: Thu, 25 Sep 2008 10:50:44 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Please pull from 'for-2.6.27'
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
	<18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
	<18639.61790.750450.103022@cargo.ozlabs.ibm.com>
	<48D0DC23.9070902@scram.de>
	<20080924224347.GA29132@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080924224347.GA29132@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

>> This isn't a regression since the stuff is new in 2.6.27. IMHO this can
>> wait until 2.6.28.
> 
> It would be a bug in 2.6.27 that did not exist in 2.6.26...  is there
> anything that used to use another mechanism that now uses this?

No, GPIO support on CPM1/CPM2 is new in 2.6.27. Before, dedicated platform 
drivers were needed to drive hardware connected to an GPIO pin.

> That's not to say that it's necessarily critical enough this late in the
> process, but in general I'm not very comfortable with not being able to
> fix newly added code as soon as the merge window closes because it's not
> a "regression".

If i understood Linus correctly, this fix will have to wait for 2.6.28, but
then it can also enter the 2.6.27 stable series (like 2.6.27.1).

Thanks,
Jochen
