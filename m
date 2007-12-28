Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 93759DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 17:18:49 +1100 (EST)
Message-ID: <47749548.8020908@pikatech.com>
Date: Fri, 28 Dec 2007 01:18:48 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Problems with arch/powerpc
References: <47742519.8060502@pikatech.com><20071227194753.56bc92f8@vader.jdub.homelinux.org>
	<477493D9.7070700@pikatech.com>
In-Reply-To: <477493D9.7070700@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And one more thought, could uClibc be causing problems with the new 
kernel? It just seems strange that kernel "stuff" seems to work (e.g. no 
problems mounting a usbkey) yet a simple setjmp in a user mode app reeks 
havoc.

We are going to be moving away from uClibc in the short term (I am the 
only one left using it). So if this could be an issue I might have to 
bite the bullet and switch now.

Cheers,
   Sean
