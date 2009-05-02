Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64D6ADDF34
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 17:49:25 +1000 (EST)
Date: Sat, 2 May 2009 09:49:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] windfarm: Convert to a new-style i2c drivers
Message-ID: <20090502094909.3b70b216@hyperion.delvare>
In-Reply-To: <18939.54528.381551.291247@cargo.ozlabs.ibm.com>
References: <20090416185615.2f7914ca@hyperion.delvare>
	<18939.54528.381551.291247@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2 May 2009 15:07:12 +1000, Paul Mackerras wrote:
> Jean Delvare writes:
> 
> > The legacy i2c binding model is going away soon, so convert the
> > macintosh windfarm drivers to the new model or they will break.
> 
> All works OK on my quad G5 (PowerMac11,2).
> 
> Tested-by: Paul Mackerras <paulus@samba.org>

Great, thanks for the test results Paul! Only therm_windtunnel still
needs to be tested.

-- 
Jean Delvare
