Return-Path: <flucifredi@acm.org>
Received: from mail24.sea5.speakeasy.net (mail24.sea5.speakeasy.net
	[69.17.117.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6597667A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 11:23:51 +1100 (EST)
Message-ID: <41F833E7.2080508@acm.org>
Date: Wed, 26 Jan 2005 19:20:55 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bora_=DEahin?= <bora.sahin@ttnet.net.tr>,
	"Linux-ppc [mailing list]" <linuxppc-embedded@ozlabs.org>
References: <41DDA5DA.1030802@acm.org><3535657973.20050126204614@ttnet.net.tr><41F816F6.8090204@acm.org><371777686.20050127005702@ttnet.net.tr>	
	<41F828EB.4040409@acm.org> <396073913.20050127020839@ttnet.net.tr>
In-Reply-To: <396073913.20050127020839@ttnet.net.tr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: MPC8272ADS and frame buffer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bora Þahin wrote:

>Hello Federico,
>
>Thanks for the infos...
>
>FL> You also 
>FL> want to test that the buffer setup of the whole thing is designed 
>FL> correctly for the kind of response and thruput you will need... I have 
>FL> seen reports on the mailing list of people having trouble b/c of some 
>FL> crippleware used in bus implementations.
>
>I dont understand it exactly. May you able to explain it a bit clearly?
>
>Thanks for the infos...
>  
>
I meant that you have to stress-test the bus connection that you are 
going to use to whatever graphic hardware you
select - you cannot count on embedded hardware being bleeding-edge 
performance, and you are going to play 25 or 30 frames a second over 
that bus -- it is a lot of data, and you have bandwidth (hopefully not a 
problem with pci) and jitter (delay variance) constraints.

    -Federico

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
