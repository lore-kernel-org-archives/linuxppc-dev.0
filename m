Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id A1762DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 06:45:31 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so307995ywb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 11:45:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090306184038.GA20537@zod.rchland.ibm.com>
References: <49B1605C.7090709@embeddedarm.com>
	<20090306184038.GA20537@zod.rchland.ibm.com>
Date: Fri, 6 Mar 2009 12:45:30 -0700
Message-ID: <fa686aa40903061145n2f45642eha50062aa8567131b@mail.gmail.com>
Subject: Re: [PATCH, RFC]
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Eddie Dawydiuk <eddie@embeddedarm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 6, 2009 at 11:40 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Fri, Mar 06, 2009 at 10:41:48AM -0700, Eddie Dawydiuk wrote:
>> @@ -214,8 +214,12 @@
>> =A0 =A0 =A0platformo=3D"$object/simpleboot.o $object/virtex.o"
>> =A0 =A0 =A0binary=3Dy
>> =A0 =A0 =A0;;
>> +simpleboot-yosemite)
>> + =A0 =A0platformo=3D"$object/fixed-head.o $object/simpleboot.o
>> $object/simpleboot-yosemite.o"
>> + =A0 =A0binary=3Dy
>> + =A0 =A0;;
>> =A0simpleboot-*)
>> - =A0 =A0platformo=3D"$object/simpleboot.o"
>> + =A0 =A0platformo=3D"$object/fixed-head.o $object/simpleboot.o"
>
> Does this break other boards, or should it have always been there?

This probably should have always been there.  Same for the simpleboot
virtex targets, but I'll need to test to be sure.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
