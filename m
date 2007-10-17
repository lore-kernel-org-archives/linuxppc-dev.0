Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20071015003703.GA14108@localhost.localdomain>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
	<1192195728-24189-7-git-send-email-leoli@freescale.com>
	<1192195728-24189-8-git-send-email-leoli@freescale.com>
	<1192195728-24189-9-git-send-email-leoli@freescale.com>
	<1192195728-24189-10-git-send-email-leoli@freescale.com>
	<20071015003703.GA14108@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <09B82C85-E2DE-46AD-8ABC-B7A261BAFF6D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 9/9] add MPC837x MDS board default device tree
Date: Wed, 17 Oct 2007 08:59:23 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 14, 2007, at 7:37 PM, David Gibson wrote:

> On Fri, Oct 12, 2007 at 09:28:48PM +0800, Li Yang wrote:
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>>  arch/powerpc/boot/dts/mpc8377_mds.dts |  288 +++++++++++++++++++++ 
>> +++++++++
>>  arch/powerpc/boot/dts/mpc8378_mds.dts |  268 +++++++++++++++++++++ 
>> +++++++
>>  arch/powerpc/boot/dts/mpc8379_mds.dts |  308 +++++++++++++++++++++ 
>> ++++++++++++
>>  3 files changed, 864 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
>> b/arch/powerpc/boot/dts/mpc8377_mds.dts
> [snip]
>> +	soc837x@e0000000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		device_type = "soc";
>> +		ranges = <0 e0000000 00100000>;
>> +		reg = <e0000000 00000200>;
>> +		bus-frequency = <0>;
>> +
>> +		wdt@200 {
>> +			device_type = "watchdog";
>
> Drop this device_type.
>
>> +			compatible = "mpc83xx_wdt";
>> +			reg = <200 100>;
>> +		};
>> +
>> +		i2c@3000 {
>> +			device_type = "i2c";
>
> And this one.

I've asked Leo to leave this one as all other fsl boards do this and  
the code depends on it.  There was some discussion about this but I  
wasn't sure if it was closed or not.

>> +			compatible = "fsl-i2c";
>> +			reg = <3000 100>;
>> +			interrupts = <e 8>;
>> +			interrupt-parent = < &ipic >;
>> +			dfsrr;
>> +		};
>> +

- k
