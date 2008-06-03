Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 7FC6BDDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 03:26:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 2/3] virtio_console: use virtqueue notification for
	hvc_console
Date: Tue, 3 Jun 2008 19:24:41 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031446.15330.borntraeger@de.ibm.com>
In-Reply-To: <200806031446.15330.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031924.42464.arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 June 2008, Christian Borntraeger wrote:
>  
> +/* The hvc device */
> +struct hvc_struct *hvc;
> +

I guess this should be static, a three letter identifier for a global variable
is not really unique.

	Arnd <><
