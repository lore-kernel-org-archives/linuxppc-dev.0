Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EDD48DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 02:44:11 +1000 (EST)
Message-ID: <4666E453.2000302@am.sony.com>
Date: Wed, 06 Jun 2007 09:44:03 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 07/18] PS3: Make ps3av.h usable from user space
References: <20070606024407.786638029@am.sony.com>>
	<46662337.9060908@am.sony.com> <20070606074609.GA31975@lst.de>
In-Reply-To: <20070606074609.GA31975@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
> On Tue, Jun 05, 2007 at 08:00:07PM -0700, Geoff Levand wrote:
>> The user applications to manage the PS3 AV modes can use values
>> defined in this header.
> 
> NACK.  First please don't introduce new unifdef-y headers but always
> separated them.  Second I don't see any of the values actually used
> in a user<->kerne interface.  If the application only happens to use
> the same values it should ship a copy of the header intead.

Yes, they are currently used with ioctl for video mode selection
by the ps3videomode utility.

OK, you recommend having two headers one for the kernel and one for
the application or library, then keeping them in sync.  I think
in some ways that is easier for the package user also, since there
is no dependency on kernel headers.  It does mean that the package
definitions need to be kept up to date.

-Geoff
