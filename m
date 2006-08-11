Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 0800167BA6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 02:30:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Debugging with no serial port
Date: Fri, 11 Aug 2006 09:30:57 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487106008A04@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <bwarren@qstreams.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
> > =09
> > I tried this as well and have the same GDB synchronization=20
> problem e.g.
> >=20
> > break log_stuff
> > commands
> >    silent
> >    if (variable_logging_enabled)
> >       printf "(%d,%d)\n",stuff1_variable,stuff2_variable
> >    end
> >    cont
> > end
> >=20
> That's too bad.  I wonder if you could run gdb from expect or=20
> some other auto-scripting language and have it issue the=20
> 'cont' once all data is printed (Have your code spit out a=20
> special 'end of data' delimiter).=20
>=20
> Just a thought - no idea if it would work. =20
>=20

What a brilliant idea!  I tried this and it works perfectly.  Having no
previous expect experience, I was able to generate and modify the expect
script with "autoexpect" in about 10 minutes.

Thanks!
Tim
