Return-Path: <flucifredi@acm.org>
Received: from mail21.sea5.speakeasy.net (mail21.sea5.speakeasy.net
	[69.17.117.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4DC267A81
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jan 2005 04:34:40 +1100 (EST)
Message-ID: <41FA7703.20304@acm.org>
Date: Fri, 28 Jan 2005 12:31:47 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bora_=DEahin?= <bora.sahin@ttnet.net.tr>,
	"Linux-ppc [mailing list]" <linuxppc-embedded@ozlabs.org>
References: <41DDA5DA.1030802@acm.org><3535657973.20050126204614@ttnet.net.tr><41F816F6.8090204@acm.org><371777686.20050127005702@ttnet.net.tr><41F828EB.4040409@acm.org>	
	<396073913.20050127020839@ttnet.net.tr><41F833E7.2080508@acm.org>
	<551817263.20050128123639@ttnet.net.tr>
In-Reply-To: <551817263.20050128123639@ttnet.net.tr>
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

>Hi Federico,
>
>FL> I meant that you have to stress-test the bus connection that you are
>FL> going to use to whatever graphic hardware you
>FL> select - you cannot count on embedded hardware being bleeding-edge 
>FL> performance, and you are going to play 25 or 30 frames a second over 
>FL> that bus -- it is a lot of data, and you have bandwidth (hopefully not a 
>FL> problem with pci) and jitter (delay variance) constraints.
>
>Sory for the late answer...
>
>I see you. In fact I know it but some blurry situations is matter. We use IBM-PPC. It has
>CoreConnect bus. I dont know implementation details of it but it has three different buses. One is
>PLB. This is for speedy ones. PCI bridge is in this bus also. AFAIK, data and addres bus of it is
>decoupled. Clock speed is also high. I think it also support burst mode. So in the light of these
>infos it seems enough. So PCI is enough, this one sholud be enough also.
>
>But as you said, we should take into consideration that these cpus and buses are embedded and at
>some points, may have clipped version of desktop brothers.
>
>  
>
Exactly. And even when the cpu is not clipped, the board might be (I am 
handling right now a fully complete Motorola MPC8272 based design, the 
chip supports PCI burst, the board design, however, does not).

-Federico

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
