Return-Path: <prvs=097182909d=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E13312C00E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2013 22:11:03 +1000 (EST)
Message-ID: <5236F54A.50102@keymile.com>
Date: Mon, 16 Sep 2013 14:10:50 +0200
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
 <5232D778.20007@keymile.com>
 <1B0AEBE4-FAE3-405C-8BAE-CACF5B12CB59@kernel.crashing.org>
In-Reply-To: <1B0AEBE4-FAE3-405C-8BAE-CACF5B12CB59@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/2013 04:53 PM, Kumar Gala wrote:
> On Sep 13, 2013, at 4:14 AM, Valentin Longchamp wrote:
>> On 09/11/2013 08:58 AM, Prabhakar Kushwaha wrote:
>>> +
>>> +&pci0 {
>>> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
>>> +	device_type = "pci";
>>> +	#size-cells = <2>;
>>> +	#address-cells = <3>;
>>> +	bus-range = <0x0 0xff>;
>>> +	interrupts = <20 2 0 0>;
>>> +	fsl,iommu-parent = <&pamu0>;
>>> +	pcie@0 {
>>> +		reg = <0 0 0 0 0>;
>>> +		#interrupt-cells = <1>;
>>> +		#size-cells = <2>;
>>> +		#address-cells = <3>;
>>> +		device_type = "pci";
>>> +		interrupts = <20 2 0 0>;
>>> +		interrupt-map-mask = <0xf800 0 0 7>;
>>> +		interrupt-map = <
>>> +			/* IDSEL 0x0 */
>>> +			0000 0 0 1 &mpic 40 1 0 0
>>> +			0000 0 0 2 &mpic 1 1 0 0
>>> +			0000 0 0 3 &mpic 2 1 0 0
>>> +			0000 0 0 4 &mpic 3 1 0 0
>>> +			>;
>>> +	};
>>> +};
>>> +
>>> +&pci1 {
>>> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
>>> +	device_type = "pci";
>>> +	#size-cells = <2>;
>>> +	#address-cells = <3>;
>>> +	bus-range = <0 0xff>;
>>> +	interrupts = <21 2 0 0>;
>>> +	fsl,iommu-parent = <&pamu0>;
>>> +	pcie@0 {
>>> +		reg = <0 0 0 0 0>;
>>> +		#interrupt-cells = <1>;
>>> +		#size-cells = <2>;
>>> +		#address-cells = <3>;
>>> +		device_type = "pci";
>>> +		interrupts = <21 2 0 0>;
>>> +		interrupt-map-mask = <0xf800 0 0 7>;
>>> +		interrupt-map = <
>>> +			/* IDSEL 0x0 */
>>> +			0000 0 0 1 &mpic 41 1 0 0
>>> +			0000 0 0 2 &mpic 5 1 0 0
>>> +			0000 0 0 3 &mpic 6 1 0 0
>>> +			0000 0 0 4 &mpic 7 1 0 0
>>> +			>;
>>> +	};
>>> +};
>>> +
>>> +&pci2 {
>>> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
>>> +	device_type = "pci";
>>> +	#size-cells = <2>;
>>> +	#address-cells = <3>;
>>> +	bus-range = <0x0 0xff>;
>>> +	interrupts = <22 2 0 0>;
>>> +	fsl,iommu-parent = <&pamu0>;
>>> +	pcie@0 {
>>> +		reg = <0 0 0 0 0>;
>>> +		#interrupt-cells = <1>;
>>> +		#size-cells = <2>;
>>> +		#address-cells = <3>;
>>> +		device_type = "pci";
>>> +		interrupts = <22 2 0 0>;
>>> +		interrupt-map-mask = <0xf800 0 0 7>;
>>> +		interrupt-map = <
>>> +			/* IDSEL 0x0 */
>>> +			0000 0 0 1 &mpic 42 1 0 0
>>> +			0000 0 0 2 &mpic 9 1 0 0
>>> +			0000 0 0 3 &mpic 10 1 0 0
>>> +			0000 0 0 4 &mpic 11 1 0 0
>>> +			>;
>>> +	};
>>> +};
>>> +
>>> +&pci3 {
>>> +	compatible = "fsl,t1042-pcie", "fsl,qoriq-pcie-v2.4", "fsl,qoriq-pcie";
>>> +	device_type = "pci";
>>> +	#size-cells = <2>;
>>> +	#address-cells = <3>;
>>> +	bus-range = <0x0 0xff>;
>>> +	interrupts = <23 2 0 0>;
>>> +	fsl,iommu-parent = <&pamu0>;
>>> +	pcie@0 {
>>> +		reg = <0 0 0 0 0>;
>>> +		#interrupt-cells = <1>;
>>> +		#size-cells = <2>;
>>> +		#address-cells = <3>;
>>> +		device_type = "pci";
>>> +		interrupts = <23 2 0 0>;
>>> +		interrupt-map-mask = <0xf800 0 0 7>;
>>> +		interrupt-map = <
>>> +			/* IDSEL 0x0 */
>>> +			0000 0 0 1 &mpic 43 1 0 0
>>> +			0000 0 0 2 &mpic 0 1 0 0
>>> +			0000 0 0 3 &mpic 4 1 0 0
>>> +			0000 0 0 4 &mpic 8 1 0 0
>>> +			>;
>>> +	};
>>> +};
>>> +
>>
>> The above 4 nodes have the consequence that it will then be mandatory that a
>> board support .dts file that would like to inlcude the SOC-NAMEsi-post.dtsi
>> defines the pci0, pci1, pci2, pci3 aliases.
>>
>> Now it is possible that a board does not implement pci1 for instance. So its
>> .dts file would ideally not define a node for it, and thus not define the
>> respective alias. However, this triggers this dtc compile error (which is correct):
>>
>>> [chlongv1@chber1-10533x linux-km]$ make kmp204x.dtb
>>>  DTC     arch/powerpc/boot/kmp204x.dtb
>>> Error: arch/powerpc/boot/dts/fsl/p2041si-post.dtsi:98.2-3 label or path, 'pci1', not found
>>> FATAL ERROR: Syntax error parsing input tree
>>> make[1]: *** [arch/powerpc/boot/kmp204x.dtb] Error 1
>>> make: *** [kmp204x.dtb] Error 2
>>
>> The solution I have found is to define a "dummy" disabled node so that I can
>> define the alias, but I am not really happy about this:
>>
>>> 	pci1: pcie@ffe201000 {
>>> 		status = "disabled";
>>> 	};
>>
>> I am here missing something obvious or shouldn't it be possible that such .dtsi
>> files allow not to define unused/unnecessary nodes ?
> 
> Isn't this correct, that you are disabling the PCIe1 interface on the SoC for your board?
> 

Yes it is correct. So this confirms that a board .dts file must disable all not
used interfaces/peripherals with such a "disabled" node.

I just wanted to be sure that this was the correct way of doing things and that
I had not missed a "better" way (where you don't need to define such "disabled"
nodes in .dts files).

Valentin
