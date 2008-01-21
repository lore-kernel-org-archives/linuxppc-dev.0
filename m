Return-Path: <r.marek@assembler.cz>
Received: from ms.trustica.cz (ms.trustica.cz [82.208.32.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ms.trustica.cz", Issuer "www.trustica.cz" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 11702DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 22:17:00 +1100 (EST)
Message-ID: <479478C7.5060807@assembler.cz>
Date: Mon, 21 Jan 2008 11:49:43 +0100
From: Rudolf Marek <r.marek@assembler.cz>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/3] i2c: Use the standard, alias-based device/driver
	matching scheme
References: <20080121112517.6fe35a89@hyperion.delvare>
In-Reply-To: <20080121112517.6fe35a89@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

> Note: all the arm and powerpc stuff is untested.

We at http://sysgo.com have some demo server, where you can access embedded 
systems remotely (via VNC to a server with cross tools (ELinOS)  + serial console),
there is 2.6.22 kernel, but I think the i2c core can be replaced. I think some 
PPC and ARMs are connected there. I will ask if you can get access to it if you 
are interested.

Thanks,

Rudolf
