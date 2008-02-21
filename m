Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-13.bluehost.com (outbound-mail-13.bluehost.com
	[69.89.18.113]) by ozlabs.org (Postfix) with SMTP id 7D01FDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 18:05:36 +1100 (EST)
Message-ID: <47BD212B.6090809@dlasys.net>
Date: Thu, 21 Feb 2008 01:58:51 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Xilinx  PowerPC
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

    So when you have Xilinx under powerpc working, do we pull it from your
    git tree or the xilinx one ?

    Will there be an announcement ?

    How about a one paragraph getting started guide to moving a xilinx
ppc bsp to
    xilinx powerpc.

    Like  ?

    step 1).
             Generate a dts - gen-mhs-devicetree ?
             And pass it to through your boot loader to Linux ?
   
    Step 2).
             the code in arch/powerpc/???? is the devicetree equvalent to
             arch/ppc/platforms/4xx/xilinx_ml410.c

    Step 3).
             device drivers need to change initialization/setup from
             ???? to ???
      
    Just something to give those of us with no clue, a small one to start.

     Thanks.
