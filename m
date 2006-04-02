Return-Path: <tnt@246tNt.com>
Received: from outmx027.isp.belgacom.be (outmx027.isp.belgacom.be
	[195.238.4.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73274679F9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Apr 2006 03:40:47 +1000 (EST)
Received: from outmx027.isp.belgacom.be (localhost [127.0.0.1])
	by outmx027.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k32HeXuw005988
	for <linuxppc-embedded@ozlabs.org>; Sun, 2 Apr 2006 19:40:33 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <44300CEC.5040007@246tNt.com>
Date: Sun, 02 Apr 2006 19:42:04 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, idefix@fechner.net
Subject: Re: Kernel for MPC Lite 5200 will not compile
References: <20060328000703.GA95672@server.idefix.loc>	<4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>	<20060328094939.GA43123@server.idefix.loc>	<4b73d43f0603280815n3fc7bb5dq38b72f87f18b905f@mail.gmail.com>	<4429A0E5.8010308@246tNt.com>
	<20060401091900.GA2740@server.idefix.loc>
In-Reply-To: <20060401091900.GA2740@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias Fechner wrote:
> Hello Sylvain,
>
> * Sylvain Munaut <tnt@246tNt.com> [28-03-06 22:47]:
>   
>> If it still doesnt work, report it and I'll have a closer look. Maybe
>> something changed
>> recently and I didn't update my tree since a few days ...
>>     
>
> ok, I have now the board to really test it.
> I tried to boot over NFS, the kernel was loaded successfully but it
> will not really boot, I got:
>   
Well, if you didn't find the network driver then booting over NFS is not
gonna happen ...
and since (see below) you didn't configure the console properly either,
you can't
even see the error message ...

> bootargs=root=/dev/nfs rw nfsroot=192.168.0.151:/usr/local/eldk/ppc_6xx ip=192.168.0.101:192.168.0.151:192.168.0.151:255.255.255.0:icecube::off
>
>   
As I said earlier in this thread, you need console=ttyPSC0 in your
kernel command line, else, you
just won't see anything on the serial except very early debug.

> I tried to find if the networkcard from the board will work, but I
> cannot find a driver in the kernel for it.
> What can be the problem for this?
>   
Well, you didn't pull from the bestcomm head maybe ?



PS: Please cc me when answering ... without it I might miss the mail ...


Sylvain
