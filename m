Return-Path: <jcd@tribudubois.net>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by ozlabs.org (Postfix) with ESMTP id 7944EDDE9C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 04:07:38 +1100 (EST)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel symbol version history
Date: Wed, 5 Dec 2007 18:07:35 +0100
References: <4756CF15.2090805@dlasys.net>
In-Reply-To: <4756CF15.2090805@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712051807.36357.jcd@tribudubois.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

You could try the various "linux cross reference" web site out there. It is 
not necessarily complete (some linux version might be missing)  but it can be 
usefull to lookup if some symbols/define/typedef were available in a 
particular Linux version.

Have a look there.

http://free-electrons.com/community/kernel/lxr

Regards

JC

On Wednesday 05 December 2007 17:17:25 David H. Lynch Jr. wrote:
>     This might be slightly OT here, but would anyone know where there
> might be a reference that indicates at precisely what version a given
> symbol either appeared or disappeared within the  Linux kernel ?
>
>      As an example if a driver is supposed to work for 2.6 and 2.4 and
> uses sysfs, or cdev, or alloc_chr_dev_region or ...
>     How can one tell at what point that api or symbol appeared so that
> the proper conditionals appear within the driver.
>
>     The last one that bit me was I made a collection of casting changes
> to address 64bit vs. 32bit targets, and found that using the C99 fixed
> size types - uint32_t, ... made life much more pleasant, after putting
> them I nobody else could build because uintptr_t did not appear until
> 2.6.24, and I still have not figured out exactly when uint32_t etc.
> appeared.
>
>     I would think there ought to be some resource besides group memory
> to look this up ?
>     Is there a way to use git to look back through the history of a
> symbol rather than a file.
