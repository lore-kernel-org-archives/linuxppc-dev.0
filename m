Return-Path: <temerkhanov@yandex.ru>
Received: from smtp5.yandex.ru (smtp5.yandex.ru [87.250.248.71])
	by ozlabs.org (Postfix) with ESMTP id C6946DDFF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 08:12:28 +1000 (EST)
Received: from ppp91-76-72-246.pppoe.mtu-net.ru ([91.76.72.246]:55870 "EHLO
	asus-a6t.local" smtp-auth: "temerkhanov" TLS-CIPHER:
	"DHE-RSA-AES256-SHA
	keybits 256/256 version TLSv1/SSLv3" TLS-PEER-CN1: <none>)
	by mail.yandex.ru with ESMTP id S1053557AbXIEWFH (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Thu, 6 Sep 2007 02:05:07 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx FX60
Date: Thu, 6 Sep 2007 02:05:13 +0400
References: <BAY138-F2634DB70ACDB83FA7430FEB2CB0@phx.gbl>
In-Reply-To: <BAY138-F2634DB70ACDB83FA7430FEB2CB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200709060205.13956.temerkhanov@yandex.ru>
Reply-To: temerkhanov@yandex.ru
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 06 September 2007 00:40:33 Ming Liu wrote:
> >It won't. There is no hardware cache coherency on Virtex.
>
> Is that possible if we turn off the cache?

Not in current versions. Implementation of SMP will require implementing 
functions from struct smp_ops_t (defined in include/asm-ppc/machdep.h) and 
some additional work. Maybe PIC redesign/modification will be needed. And 
after all there will be significant performance hit with caches disabled.
