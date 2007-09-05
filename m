Return-Path: <temerkhanov@yandex.ru>
Received: from smtp3.yandex.ru (smtp3.yandex.ru [213.180.200.14])
	by ozlabs.org (Postfix) with ESMTP id 106EADE08C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 05:49:17 +1000 (EST)
Received: from ppp91-76-72-246.pppoe.mtu-net.ru ([91.76.72.246]:61746 "EHLO
	asus-a6t.local" smtp-auth: "temerkhanov" TLS-CIPHER:
	"DHE-RSA-AES256-SHA
	keybits 256/256 version TLSv1/SSLv3" TLS-PEER-CN1: <none>)
	by mail.yandex.ru with ESMTP id S4747327AbXIETma (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Wed, 5 Sep 2007 23:42:30 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx FX60
Date: Wed, 5 Sep 2007 23:42:33 +0400
References: <1189017748.6185.49.camel@PisteOff>
In-Reply-To: <1189017748.6185.49.camel@PisteOff>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709052342.34177.temerkhanov@yandex.ru>
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

On Wednesday 05 September 2007 22:42:28 Robert Woodworth wrote:
> After achieving complete success with my Linux kernel on the ML403, I've
> now started to build a kernel for my real target board with a
> Virtex4-FX60 (dual PPC cores)
>
> Has anyone built a kernel for a dual core PPC Virtex?  I have found very
> little docs on how to architect software for the dual-core PPC's.
> Will SMP Linux work on this platform?  What would the bus setup be?

It won't. There is no hardware cache coherency on Virtex.
