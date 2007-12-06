Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 59DAEDDE48
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 21:21:41 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] celleb: add supporting for native CBE
Date: Thu, 6 Dec 2007 11:21:19 +0100
References: <20071206.154355.-1300541609.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071206.154355.-1300541609.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061121.20289.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 06 December 2007, Ishizaki Kou wrote:
> > An interesting question still is how close the native celleb machine
> > definition is to the one from platforms/cell/setup.c. Maybe it's best
> > to have a common machine definition for these two in the end.
> 
> You know celleb-native is between celleb-beat and cell blade. I also
> think it's best if we can use a common machine definition and a common
> setup code. But there are many differences mainly caused by their
> firmwares, and this disturbs the integration. I think celleb-native is
> closer to celleb-beat than to cell blade. So I put celleb-native code
> in platforms/celleb.

Ok, fine with me then. Thanks,

	Arnd <><
