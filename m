Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 13D1ADDF0C
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 03:04:12 +1100 (EST)
Received: by gxk22 with SMTP id 22so2371148gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Mar 2009 08:04:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <60135.70.162.219.205.1236439301.squirrel@oz.embeddedx86.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
	<49B19AE0.3080609@embeddedarm.com> <49B1A47F.8040005@embeddedarm.com>
	<fa686aa40903062022i2211ccdfu1bffab54749615d8@mail.gmail.com>
	<fa686aa40903062141n210f81d7g9f11154f3c78cadc@mail.gmail.com>
	<60135.70.162.219.205.1236439301.squirrel@oz.embeddedx86.com>
Date: Sat, 7 Mar 2009 09:04:10 -0700
Message-ID: <fa686aa40903070804id8f84atecb63c39747c2041@mail.gmail.com>
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

On Sat, Mar 7, 2009 at 8:21 AM, Eddie Dawydiuk <eddie@embeddedarm.com> wrot=
e:
> Hello,
>
>> On a more general note; this patch also diverges from the original
>> model for simple image. =A0The idea behind simpleimage was that it would
>> contain a fully formed device tree, with no fixups necessary. =A0I want
>> to think carefully before diverging from that.
>
> I wasn't aware of these design goals... I believe one can also modify the
> default dts file such that the RAM size is not dynamically detected so th=
e
> fixups aren't required(although keep in mind I haven't tested this).

Just to be clear, I'm not saying 'no'.  I'm just not saying 'yes' yet
either.  However, if you can fully form the dts file then that is
definitely my preference.

> Although it is quite convenient to add the fixed-head.o so one can jump
> into the simpleImage at offset 0 rather than having to check what the
> offset should be each time a change is made.

The missing fixed-head thing is a bug.  I have no issue with that change.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
