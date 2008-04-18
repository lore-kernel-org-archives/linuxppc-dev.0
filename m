Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F1477DE1EE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 22:35:44 +1000 (EST)
Message-ID: <48089591.608@scram.de>
Date: Fri, 18 Apr 2008 14:35:29 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: build breakage from of i2c helper patch
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>	<48071778.2000405@scram.de>
	<18440.34234.28845.7398@cargo.ozlabs.ibm.com>
In-Reply-To: <18440.34234.28845.7398@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux I2C <i2c@lm-sensors.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

> Which way around is this dependency?  Do you mean that the patches you
> listed depend on the "OF helpers for the i2c API" patch, or that the
> OF helpers patch depends on these other ones?

The OF helpers patch depends on the patches below to support autoloading
i2c modules using the alias mechanism. Otherwise, we need to translate
between i2c module type and driver_name in the helper patch (like currently
done in fsl_soc.c function of_find_i2c_driver()). However, this old way
doesn't really scale well.

> 
>> http://patchwork.ozlabs.org/linuxppc/patch?id=17833
>> http://patchwork.ozlabs.org/linuxppc/patch?id=17834
>>
>> or the original ones from Jean Delvare:
>>
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16282
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16283
>> http://patchwork.ozlabs.org/linuxppc/patch?id=16284
> 
> What's the best way to fix this now?  We need to get a reasonable fix
> in before I ask Linux to pull the powerpc tree.

Thanks,
Jochen
