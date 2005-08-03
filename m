Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by ozlabs.org (Postfix) with ESMTP id 1578E67E37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 16:24:02 +1000 (EST)
From: Matej Kupljen <matej.kupljen@ultra.si>
To: Daniel Ann <ktdann@gmail.com>
In-Reply-To: <9b7ca65705080218273146950c@mail.gmail.com>
References: <9b7ca65705080218273146950c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 07:55:02 +0200
Message-Id: <1123048502.10524.1.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Issue with running depmod after cross compiling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> What would be considered reasonable if I was to solve this ?

I use depmod.pl, which is i Perl script that do just that.
It is bundled with the busybox. You can find it in the 
examples subdirectory.

Hope that helps.

BR,
Matej
