Return-Path: <olh@suse.de>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 302CB67A85
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 04:37:33 +1100 (EST)
Date: Fri, 28 Jan 2005 18:37:23 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Message-ID: <20050128173723.GA4169@suse.de>
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	<d120d50005012806435a17fe98@mail.gmail.com>
	<20050128145511.GA29340@suse.de>
	<d120d500050128072268a5c2f0@mail.gmail.com>
	<20050128161746.GA1092@suse.de>
	<d120d500050128084345bb1abd@mail.gmail.com>
	<d120d500050128093472935f8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d120d500050128093472935f8a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Jan 28, Dmitry Torokhov wrote:

> On Fri, 28 Jan 2005 11:43:44 -0500, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > This time  keyboard does not hang but NAKs everything instead...
> 
> Probably stupid question - does this box have AT keyboard? Or NAKs are
> perfectly valid?

There is nothing connected. 2.6.10-bk11 works, -bk12 not. Thats a
starting point, will look at the differences now.
