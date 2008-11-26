Return-Path: <domino@mikroswiat.pl>
Received: from jupiter.az.pl (jupiter.az.pl [62.146.68.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9659FDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Nov 2008 01:54:05 +1100 (EST)
Message-ID: <492D7219.8040501@mikroswiat.pl>
Date: Wed, 26 Nov 2008 16:58:17 +0100
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: too few bogoMips on MPC8313E-RDB ?
References: <492D1CA5.2090007@aimvalley.nl>	<20081126102042.GA11397@mail.gnudd.com>
	<492D5B38.3080709@aimvalley.nl>
In-Reply-To: <492D5B38.3080709@aimvalley.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Norbert van Bolhuis wrote:
>
> Thanks for the answer, but that's not it.
>
> I checked the jiffies variable, it increases about 250 times
> per second.
> So the (mpc83xx_defconfig) kernel perception (#define CONFIG_HZ 250)
> is OK.
>
> It must be something else, I still think 83.20 BogoMIPS
> can't be correct for a MPC8313 running at 333 MHz.
>
>
> Alessandro Rubini wrote:
>>> This is what a linux-2.6.x reports (for the MPC8313E running at 333
>>> MHz):
>>> Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)


I never been worried for the BogoMIPS, but actually my board (custom
one) report:
Calibrating delay loop... 66.56 BogoMIPS (lpj=133120)
The core is running at 333MHz also, but what make my focus is the result
of calibrating: 66.56. The main oscillator on my board is 66MHz!? Is the
main oscillator on your board 83.3MHz?
BTW. I'm using older kernel 2.6.20 with patches from freescale.

Regards
