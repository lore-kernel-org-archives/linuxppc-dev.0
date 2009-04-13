Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1051FDE055
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 09:07:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18915.50615.952282.915946@cargo.ozlabs.ibm.com>
Date: Tue, 14 Apr 2009 09:07:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] therm_pm72: Convert to a new-style i2c driver
In-Reply-To: <20090413160927.3b8675b8@hyperion.delvare>
References: <20090413160927.3b8675b8@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare writes:

> The legacy i2c binding model is going away soon, so convert the
> macintosh therm_pm72 driver to the new model or it will break.
> 
> This is really a quick and dirty conversion, that should do the trick
> for now, but no doubt that something cleaner can be done if anyone is
> interested.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Seems to work fine on my powermac7,2 machine (dual 2.0GHz G5).

Tested-by: Paul Mackerras <paulus@samba.org>

Paul.
