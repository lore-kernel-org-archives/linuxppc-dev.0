Return-Path: <tnt@246tNt.com>
Received: from outmx014.isp.belgacom.be (outmx014.isp.belgacom.be
	[195.238.4.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A54CDDDF86
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 05:00:58 +1100 (EST)
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
	by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l25I0lD8030079
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 19:00:47 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45EC5AA2.40100@246tNt.com>
Date: Mon, 05 Mar 2007 19:00:02 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Juan Lopez <dgalari@gmail.com>
Subject: Re: boot LITE5200B
References: <3184691b0703050957n6ccbdd84x6e01dba9985d5b2c@mail.gmail.com>
In-Reply-To: <3184691b0703050957n6ccbdd84x6e01dba9985d5b2c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Juan Lopez wrote:
> Hello all,
>
> I have a problem to boot a linux image in a Freescale LITE5200B, I
> compile a Kernel image
What kernel  version, what origin ? ...

> bootargs=root=/dev/mtdblock3 ro console=ttyS1 rootfstype=jffs2
>
>   
The console = ttyS1 sounds weird ... there is only 1 serial on the
lite5200b IIRC


For 2.4 that's ttyS0
For 2.6 ttyPSC0


    Sylvain
