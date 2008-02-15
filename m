Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id A23B3DDEBB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 05:11:49 +1100 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by fusion.kanatek.com with esmtp (Exim 4.66)
	(envelope-from <sean.maclennan@pikatech.com>) id 1JQ52w-0004cl-Nv
	for linuxppc-dev@ozlabs.org; Fri, 15 Feb 2008 13:12:26 -0500
Message-ID: <47B5E3CA.5050208@pikatech.com>
Date: Fri, 15 Feb 2008 14:11:06 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
Subject: NOR flash partitions gone
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I did a git pull of Josh's for-2.6.25 tree. Now the NOR partitions are 
no longer setup.

				nor_flash@0,0 {
					compatible = "amd,s29gl032a", "cfi-flash";
					bank-width = <2>;
					reg = <0 0 400000>;
					#address-cells = <1>;
					#size-cells = <1>;
					partition@300000 {
						label = "fpga";
						reg = <300000 40000>;
					};
					partition@340000 {
						label = "env";
						reg = <340000 40000>;
					};
					partition@380000 {
						label = "u-boot";
						reg = <380000 80000>;
					};
				};



It still detects the chip, it just doesn't configure the partitions. Any 
ideas?

Cheers,
   Sean
