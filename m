Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 65B35688D6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 23:02:52 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 28 Dec 2005 13:02:45 +0100
References: <200512271730.28563.david.jander@protonic.nl>
	<43B26CA1.4040700@grandegger.com>
In-Reply-To: <43B26CA1.4040700@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512281302.46210.david.jander@protonic.nl>
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi again,

On Wednesday 28 December 2005 11:44, Wolfgang Grandegger wrote:
> AFAIK, there is no _generic_ embedded CAN driver available which even
> supports real-time extensions.

Yes, lincan does. Well, it supports RTlinux and OCERA's RTlinux (GPL) 
modifications, which somehow reinvent ADEOS (or is it the other way around?), 
but since RTlinux is an option only for i386, and anyway almost dead right 
now, you could say it doesn't support real-time extensions.

The problem of saying "Peak-CAN for SJA1000" and "OCAN for intel" is that you 
can basically forget about writing portable code because they are both very 
different.

Maybe you should have a look at Pavel Pisa's lincan. After trying it out you 
might end up as confused as I am, because it doesn't look that bad at all, 
it's almost platform independent, supports all kernels (2.2 to latest 2.6), 
and supports a great amount of cards with intel and/or philips chips (yes, 
both of them on one card is also an option). The driver is designed with 
performance and throughput in mind, but I am not so sure about the API which 
is still a little too simple (maybe that's actually good) and doesn't support 
properly checking chip- or  bus-status yet. Also honorable is their effort of 
staying compatible with at least one other player: can4linux.

Greetings, and thanks for the comments,

Btw, how's ELDK-4 coming along?

-- 
David Jander
Protonic Holland.
