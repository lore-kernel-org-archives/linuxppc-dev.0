Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18440.34234.28845.7398@cargo.ozlabs.ibm.com>
Date: Fri, 18 Apr 2008 21:27:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: build breakage from of i2c helper patch
In-Reply-To: <48071778.2000405@scram.de>
References: <CDDD8C0A-4B40-4CA7-BB84-50B2A93C7804@kernel.crashing.org>
	<48071778.2000405@scram.de>
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

Jochen Friedrich writes:

> It looks like it. i2c-core needs to be compiled static for the OF
> bindings to work.
> I guess in Kconfig "depends on OF && I2C" must be changed into
> "depends on OF && (I2C=y)"
> 
> On the other hand, i didn't test the patch without the dependent
> patches, so it might not work as expected:

Which way around is this dependency?  Do you mean that the patches you
listed depend on the "OF helpers for the i2c API" patch, or that the
OF helpers patch depends on these other ones?

> http://patchwork.ozlabs.org/linuxppc/patch?id=17833
> http://patchwork.ozlabs.org/linuxppc/patch?id=17834
> 
> or the original ones from Jean Delvare:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=16282
> http://patchwork.ozlabs.org/linuxppc/patch?id=16283
> http://patchwork.ozlabs.org/linuxppc/patch?id=16284

What's the best way to fix this now?  We need to get a reasonable fix
in before I ask Linux to pull the powerpc tree.

Paul.
