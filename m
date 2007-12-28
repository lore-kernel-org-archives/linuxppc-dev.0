Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 8ACF3DDDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 00:25:17 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so642186anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 05:25:16 -0800 (PST)
Date: Fri, 28 Dec 2007 07:25:12 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Problems with arch/powerpc
Message-ID: <20071228072512.01c6eba8@vader.jdub.homelinux.org>
In-Reply-To: <47749548.8020908@pikatech.com>
References: <47742519.8060502@pikatech.com>
	<20071227194753.56bc92f8@vader.jdub.homelinux.org>
	<477493D9.7070700@pikatech.com> <47749548.8020908@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Dec 2007 01:18:48 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> And one more thought, could uClibc be causing problems with the new 
> kernel? It just seems strange that kernel "stuff" seems to work (e.g. no 
> problems mounting a usbkey) yet a simple setjmp in a user mode app reeks 
> havoc.
> 
> We are going to be moving away from uClibc in the short term (I am the 
> only one left using it). So if this could be an issue I might have to 
> bite the bullet and switch now.

Does the setjmp call use floating point instructions?  I'm wondering if
the APU isn't enabled for the FPU on the Yosemite board for some
reason.  If that wasn't enabled, weird things would happen.

josh
