Return-Path: <mcr@marajade.sandelman.ca>
Received: from lists.sandelman.ca (cod.sandelman.ca [192.139.46.139])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lists.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C43D76861E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 16:12:40 +1100 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
In-Reply-To: Message from =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
	of "Thu, 27 Oct 2005 15:04:27 +0800." <1130396668.15267.6.camel@banana>
References: <1130396668.15267.6.camel@banana> 
Date: Fri, 28 Oct 2005 09:50:36 -0400
Message-ID: <5283.1130507436@marajade.sandelman.ca>
From: mcr <mcr@marajade.sandelman.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: about HDLC Ethernet Driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "rober" == rober  <UTF-8> writes:
    rober>     I used Linux 2.4.25 at my custom MPC852T and I want to
    rober> used scc with HDLC mode to communiction with another
    rober> MPC852T. How to build a ethernet base on HDLC for
    rober> communication with these two CPU?

  So, you have two MPC852Ts on a board, and they are cross-wired such
that you send HDLC between them using the scc, and you want to:
(my question):
    a) you want to reprogram the scc's to send ethernet frames?
    b) you want to encapsulate ethernet frames in HDLC?
    c) you want to connect the two 852s using some kind of IP
       networking?

  HDLC is commonly used on T1 links, and one method puts frames that
essentially look like ethernet frames over it. 

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQ2IsqoqHRg3pndX9AQFeswP/Rrsj0USUKFL5kEXBDnUznWtEFJLAI1eM
wmuAIQBw8idS/hPhbV2ox9pEeZyUk419rUigVMi9LkVqBZzyJaRulN8SdGsR28sv
X7N0uD0zNGP0MU0cerW0QXGad1oUkElWELkM2YnUWnv3+1AXW2fsoOtipPvSkAo7
P6dR3MUV3VU=
=ap8A
-----END PGP SIGNATURE-----
