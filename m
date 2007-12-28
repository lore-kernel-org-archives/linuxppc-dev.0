Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 11BF3DDDF2
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 05:35:20 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so7082669pyi.0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 10:35:18 -0800 (PST)
Date: Fri, 28 Dec 2007 12:35:14 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Problems with arch/powerpc
Message-ID: <20071228123514.7a2509c6@vader.jdub.homelinux.org>
In-Reply-To: <47752412.7040708@pikatech.com>
References: <47742519.8060502@pikatech.com>
	<20071227194753.56bc92f8@vader.jdub.homelinux.org>
	<477493D9.7070700@pikatech.com> <47749548.8020908@pikatech.com>
	<20071228072512.01c6eba8@vader.jdub.homelinux.org>
	<47752412.7040708@pikatech.com>
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

On Fri, 28 Dec 2007 11:28:02 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Josh Boyer wrote:
> > Does the setjmp call use floating point instructions?  I'm wondering if
> > the APU isn't enabled for the FPU on the Yosemite board for some
> > reason.  If that wasn't enabled, weird things would happen.
> >   
> That was it! The cputable did not have an entry for the 440EP Rev C! So 
> the FPU flag was not being set.

Cool!  Care to send a patch to add that entry?

josh
