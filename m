Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0E89967C0D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 05:48:53 +1000 (EST)
Message-ID: <44D0FDF3.4020401@ru.mvista.com>
Date: Wed, 02 Aug 2006 23:33:07 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
In-Reply-To: <9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:
> Do we want to go ahead and fix the mac address field having the wrong  
> name?

    If you mean "address" instead of "local-mac-address" then I guess 
Documentation/powerpc/booting-without-of.txt should also be changed since it 
has "address". And arch/powerpc/sysdev/fsl_soc.c as well..

>>+		ethernet@24000 {
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>>+			device_type = "network";
>>+			model = "TSEC";
>>+			compatible = "gianfar";
>>+			reg = <24000 1000>;
>>+			address = [ 00 E0 0C 00 73 00 ];
>>+			interrupts = <1d 2 1e 2 22 2>;
>>+			interrupt-parent = <40000>;
>>+			phy-handle = <2452000>;
>>+		};
>>+
>>+		ethernet@25000 {
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>>+			device_type = "network";
>>+			model = "TSEC";
>>+			compatible = "gianfar";
>>+			reg = <25000 1000>;
>>+			address = [ 00 E0 0C 00 73 01 ];
>>+			interrupts = <23 2 24 2 28 2>;
>>+			interrupt-parent = <40000>;
>>+			phy-handle = <2452001>;
>>+		};
>>+		
>>+		ethernet@26000 {
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>>+			device_type = "network";
>>+			model = "TSEC";
>>+			compatible = "gianfar";
>>+			reg = <26000 1000>;
>>+			address = [ 00 E0 0C 00 02 FD ];
>>+			interrupts = <1F 2 20 2 21 2>;
>>+			interrupt-parent = <40000>;
>>+			phy-handle = <2452002>;
>>+		};
>>+
>>+		ethernet@27000 {
>>+			#address-cells = <1>;
>>+			#size-cells = <0>;
>>+			device_type = "network";
>>+			model = "TSEC";
>>+			compatible = "gianfar";
>>+			reg = <27000 1000>;
>>+			address = [ 00 E0 0C 00 03 FD ];
>>+			interrupts = <25 2 26 2 27 2>;
>>+			interrupt-parent = <40000>;
>>+			phy-handle = <2452003>;
>>+		};

WBR, Sergei
