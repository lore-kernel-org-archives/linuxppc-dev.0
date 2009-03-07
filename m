Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id 0B34DDDF1F
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 02:14:43 +1100 (EST)
Message-ID: <60088.70.162.219.205.1236438881.squirrel@oz.embeddedx86.com>
In-Reply-To: <fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
Date: Sat, 7 Mar 2009 08:14:41 -0700 (MST)
Subject: Re: [PATCH, RFC]
From: "Eddie Dawydiuk" <eddie@embeddedarm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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

> But the question remains: Why do you need simpleboot support for
> Yosemite when you can use a uImage or cuImage with u-boot?

We are developing a new board based upon the Yosemite board. Seeing as
though the Yosemite board was supported in the mainline kernel I decided
to start with that code base. After looking at what different
options/images were available for device trees vs open firmware I decided
the simpleImage would be the ideal format for our new board. I then read
how to build a simpleImage for the Yosemite board, which build without any
compiler errors. Although I found the image didn't work, so I figured it
might be helpful for others if the image just worked without
modifications. Although shortly I will be submitting support for our
custom board using this same approach. So if you have any suggestions on
this approach using the simpleImage please let me know.

On another note, can you tell me/point me to some documentation on how to
get a unique machine ID for a new board?

--
Best Regards,
________________________________________________________________
 Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
 16525 East Laser Drive              | fax:    (480) 837-5300
 Fountain Hills, AZ 85268            | web: www.embeddedARM.com
