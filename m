Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1B516860C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Oct 2005 18:51:15 +1000 (EST)
Date: Tue, 25 Oct 2005 09:51:10 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-Id: <20051025095110.6492e7a0.ajz@cambridgebroadband.com>
In-Reply-To: <435D088C.9060000@ru.mvista.com>
References: <20051024170707.5068be0a.ajz@cambridgebroadband.com>
	<435D088C.9060000@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: m82xxhci USB driver problems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 24 Oct 2005 20:15:08 +0400
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> Maybe there's something with SOF generation - check if RCCR[EIE] is
> set. Just a pure guess...

No, it is set.
