Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2749DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:46:40 +1000 (EST)
Date: Wed, 6 Jun 2007 09:46:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 07/18] PS3: Make ps3av.h usable from user space
Message-ID: <20070606074609.GA31975@lst.de>
References: <20070606024407.786638029@am.sony.com>>
	<46662337.9060908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46662337.9060908@am.sony.com>
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

On Tue, Jun 05, 2007 at 08:00:07PM -0700, Geoff Levand wrote:
> The user applications to manage the PS3 AV modes can use values
> defined in this header.

NACK.  First please don't introduce new unifdef-y headers but always
separated them.  Second I don't see any of the values actually used
in a user<->kerne interface.  If the application only happens to use
the same values it should ship a copy of the header intead.
