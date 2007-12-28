Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 73409DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 05:13:40 +1100 (EST)
Message-ID: <47753CD3.3000209@pikatech.com>
Date: Fri, 28 Dec 2007 13:13:39 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: External int in dts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have an FPGA which uses external int 1, which is interrupt 24 on UIC0. 
I tried the following entry in various places:

        FPGA0: fpga {
            compatible = "pika,fpga";
            interrupts = <18 4>;
            interrupt-parent = <&UIC0>;
        };

Any hints, or is this the wrong way to enable an external int?

Cheers,
   Sean
