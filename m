Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1586BDDECC
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 05:18:34 +1100 (EST)
Message-ID: <47C84C66.4070006@am.sony.com>
Date: Fri, 29 Feb 2008 10:18:14 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] Fix zImage-dtb.initrd build error
References: <20080221185651.6893.78700.stgit@trillian.secretlab.ca>
	<fa686aa40802290633i2918cfbdtecb614065895f82a@mail.gmail.com>
In-Reply-To: <fa686aa40802290633i2918cfbdtecb614065895f82a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	miltonm@bga.com, Hiroaki_Fuse@hq.scei.sony.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 02/29/2008 06:33 AM, Grant Likely wrote:
> Any comments on this patch?  It needs to go in for .25, but I haven't
> gotten any Acks on it.

I have it in ps3-linux.git, and seems to work OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
