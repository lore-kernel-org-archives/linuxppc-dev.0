Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18670.42312.827841.167852@cargo.ozlabs.ibm.com>
Date: Fri, 10 Oct 2008 11:43:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> I'm waiting for someone to explain to me what's so special about CHRP
> and PMAC that these two platforms should be enabled by default, when
> all other PowerPC platforms are disabled by default.

Historically they have been the most important 32-bit platforms, along
with PReP.

The problem with making all platforms default to N is that if you take
the default values for all config options you end up with a config
that won't build.  So we want at least one platform to default to Y,
and pmac has been as good a choice as any for that (and probably still
is).

Paul.
