Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C647DE120
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 20:15:12 +1000 (EST)
Date: Thu, 17 Apr 2008 11:37:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: build breakage from of i2c helper patch
Message-ID: <20080417113703.0f24c578@hyperion.delvare>
In-Reply-To: <48071778.2000405@scram.de>
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
	<48071778.2000405@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Apr 2008 11:25:12 +0200, Jochen Friedrich wrote:
> It looks like it. i2c-core needs to be compiled static for the OF bindings to work.
> I guess in Kconfig "depends on OF && I2C" must be changed into "depends on OF && (I2C=y)"

(blind shot) Maybe this means that some code that is in i2c-core should
be moved to i2c-boardinfo instead? i2c-boardinfo is always built into
the kernel even when i2c-core is modular.

-- 
Jean Delvare
