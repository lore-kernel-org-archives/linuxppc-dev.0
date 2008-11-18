Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A852CDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 03:49:08 +1100 (EST)
Date: Tue, 18 Nov 2008 10:51:42 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: "nanda" <nanda74pg@rediffmail.com>
Subject: Re: 8360E MDS - linux 2.6.20
Message-Id: <20081118105142.4e52ff84.kim.phillips@freescale.com>
In-Reply-To: <20081118144050.8178.qmail@f5mail-237-219.rediffmail.com>
References: <20081118144050.8178.qmail@f5mail-237-219.rediffmail.com>
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

On 18 Nov 2008 14:40:50 -0000
"nanda" <nanda74pg@rediffmail.com> wrote:

> Hi All,Iam in the process of building the uImage and root file system for source linux 2.6.20 to bring up the powerpc 8360E MDS board. Please let me know whether I can get the minimum default config(.config) for building the same or any other document to guide the build.Thanks in advance.Regards,Nanda 

there should be a default config in arch/powerpc/configs - 'make
mpc8360emds_defconfig' (or mpc836x_mds_defconfig for later kernel
versions).

Kim
