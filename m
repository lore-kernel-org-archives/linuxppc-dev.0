Return-Path: <matias.sundman@ericsson.com>
Received: from mailgw3.ericsson.se (mailgw3.ericsson.se [193.180.251.60])
	by ozlabs.org (Postfix) with ESMTP id CA688679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 20:49:26 +1000 (EST)
Received: from esealmw127.eemea.ericsson.se (unknown [153.88.254.122])
	by mailgw3.ericsson.se (Symantec Mail Security) with ESMTP id 439061075
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 12:49:10 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Backtrace
Date: Fri, 1 Sep 2006 12:49:09 +0200
Message-ID: <24521B9781EAC745A4BE65966F69C9BE02BACDA9@esealmw115.eemea.ericsson.se>
In-Reply-To: <OFAC529115.08187271-ON482571DC.003802B3@uk.marconicomms.com>
From: "Matias Sundman \(AS/EAB\)" <matias.sundman@ericsson.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: =?iso-8859-1?Q?=D6rjan_Gustavsson_=28AS/EAB=29?=
	<orjan.gustavsson@ericsson.com>
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
Hello,
We have HW debuggers ; Windriver ICE and BDI2000 , but in our specific =
scenario the system is up=20
and running and we cannot be breakpoint intrusive, other parts of the =
system would be affected ( and our own blade ).
No, what we would like to do is that when a specific condition is met a =
backtrace printout
is performed and after that the system runs as designed.

 :
 [Existing code]
 :=20
 :

if ( some_variable =3D=3D my_condition )
 {
  print_out_backtrace();
 }

 :
 :
 [Existing code]
 :=20
 :

We have implemented "forced" kernel ooops:es in "print_out_backtrace();" =
but we would like to=20
have controlled backtraces ;-))


This is in Kernel space on a ppc8270.=20

Cheers // Matias

-----Original Message-----
From: KokHow Teh [mailto:KokHow.Teh@marconi.com]=20
Sent: den 1 september 2006 12:13
To: Matias Sundman (AS/EAB)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Backtrace


Hi;
      Is using hardware/software breakpoint with a hardware debugger =
what
you are looking for?

Regards,
Teh



"Matias Sundman \(AS/EAB\)" <matias.sundman@ericsson.com>@ozlabs.org on
09/01/2006 02:48:43 PM

Sent by:    =
linuxppc-embedded-bounces+kokhow.teh=3Dmarconi.com@ozlabs.org


To:    <linuxppc-embedded@ozlabs.org>
cc:

Subject:    Backtrace




Comrades,
I would like to do a backtrace in kernel space similar to an oops but =
then
continue the code flow as before i.e. without a crash.

If someone has done anything similar, help and/or tips would be much
appreciated!

Cheers //

Matias Sundman
Senior Sw Designer
Ericssonl
IS Ethernet Switch, DIPN
Ericsson AB
Box 1505=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
=A0=A0=A0=A0=A0=A0=A0 Office: +46=A0 8 719 86 83
SE-125 25 =C4LVSJ=D6=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
ECN:=A0=A0=A0 850 98683
SWEDEN=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 Mobile: +46 70 267 =
2405
Visiting address:=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0E-mail: =
Matias.Sundman@ericsson.com
Armborstv=E4gen 14=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =
Web:=A0=A0=A0 http://www.ericsson.com
=C4lvsj=F6, STOCKHOLM


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
