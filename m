Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id AF139DDF32
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 03:37:55 +1100 (EST)
Message-ID: <62692.70.162.219.205.1236443872.squirrel@oz.embeddedx86.com>
Date: Sat, 7 Mar 2009 09:37:52 -0700 (MST)
Subject: Re: [PATCH, RFC]
From: "Eddie Dawydiuk" <eddie@embeddedarm.com>
To: grant.likely@secretlab.ca
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: eddie@embeddedarm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

>> So if you have any suggestions on
>> this approach using the simpleImage please let me know.
>
> Before I answer this, what bootloader are you using?

We are using a custom bootloader we developed ourselves. The bootloader is
very minimal as one of our primary design goals is a fast boot time. We do
some basic initialization of the AMCC 440EP, then load the simpleImage
into RAM at address 0 and jump into it. In my mind I had considered our
code as more of a bootrom and the simpleboot.c as a bootloader ;)

>> On another note, can you tell me/point me to some documentation on how
>> to get a unique machine ID for a new board?
>
> What do you mean?  Are you referring to the top level compatible and
> model properties?

I think I might be getting ahead of myself, as I'm not yet up to speed on
how the powerpc code base identifies unique machines. For instance the ARM
codebase required that each new machine have a unique machine ID. When
bringing up a new platform one had to request a new unique machine ID. The
bootloader was required to pass this unique machine id to the kernel.
We're still using quite a bit of the Yosemite code base and so I had
assumed we are probably using the Yosemite boards "unique machine id" for
our custom hardware. Although based on your response it sounds like
powerpc  uses a different approach.

//Eddie
