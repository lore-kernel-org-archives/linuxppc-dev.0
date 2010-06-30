Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id B14ECB6F0C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 17:06:27 +1000 (EST)
Received: by bwz19 with SMTP id 19so211514bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 00:06:25 -0700 (PDT)
Date: Wed, 30 Jun 2010 11:06:20 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
Message-ID: <20100630070620.GA11463@oksana.dev.rtsoft.ru>
References: <5569.83301.qm@web180304.mail.gq1.yahoo.com>
	<4C2A7E14.4060802@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4C2A7E14.4060802@caviumnetworks.com>
Cc: gregkh@suse.de, linux-usb@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Mark Miesfeld <mmiesfeld@apm.com>, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 04:13:24PM -0700, David Daney wrote:
> On 06/29/2010 03:41 PM, David Brownell wrote:
> >Good -- MUSB won't be the only one.  ;)
> >
> >Could you mention a few Linux-enabled chips which
> >include this controller?
> >
> 
> I can.  Some members of the Octeon family:  arch/mips/cavium-octeon

Plus ECONA CNS3xxx (arch/arm/mach-cns3xxx).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
