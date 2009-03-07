Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id D8D2FDDF1E
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 03:06:36 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so431023ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Mar 2009 08:06:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <60088.70.162.219.205.1236438881.squirrel@oz.embeddedx86.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
	<60088.70.162.219.205.1236438881.squirrel@oz.embeddedx86.com>
Date: Sat, 7 Mar 2009 09:06:34 -0700
Message-ID: <fa686aa40903070806t3ca9749cmf9df10818f1ed2f9@mail.gmail.com>
Subject: Re: [PATCH, RFC]
From: Grant Likely <grant.likely@secretlab.ca>
To: eddie@embeddedarm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 7, 2009 at 8:14 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrote:
> Hello,
>
>> But the question remains: Why do you need simpleboot support for
>> Yosemite when you can use a uImage or cuImage with u-boot?
>
> We are developing a new board based upon the Yosemite board. Seeing as
> though the Yosemite board was supported in the mainline kernel I decided
> to start with that code base. After looking at what different
> options/images were available for device trees vs open firmware I decided
> the simpleImage would be the ideal format for our new board. I then read
> how to build a simpleImage for the Yosemite board, which build without any
> compiler errors. Although I found the image didn't work, so I figured it
> might be helpful for others if the image just worked without
> modifications. Although shortly I will be submitting support for our
> custom board using this same approach. So if you have any suggestions on
> this approach using the simpleImage please let me know.

Before I answer this, what bootloader are you using?

> On another note, can you tell me/point me to some documentation on how to
> get a unique machine ID for a new board?

What do you mean?  Are you referring to the top level compatible and
model properties?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
