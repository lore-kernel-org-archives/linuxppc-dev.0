Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 4A9D1DDEC4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:00:46 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so5372341mue
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 09:00:45 -0700 (PDT)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] SPI: Use fsl_spi instead of mpc83xx_spi
References: <87hcl8xkw5.fsf@macbook.be.48ers.dk>
	<fa686aa40710030852q6f88002amafd33fd773833eb5@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 18:00:37 +0200
In-Reply-To: <fa686aa40710030852q6f88002amafd33fd773833eb5@mail.gmail.com>
	(Grant Likely's message of "Wed\, 3 Oct 2007 09\:52\:53 -0600")
Message-ID: <878x6kxk62.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 >> -                       compatible = "mpc83xx_spi";
 >> +                       compatible = "fsl_spi";

 Grant> Compatible is a list property; this might be more appropriate:

 Grant> compatible = "fsl,mpc8313_spi", "fsl_spi";

Fine by me, I'm just following booting-without-of.txt.

-- 
Bye, Peter Korsgaard
