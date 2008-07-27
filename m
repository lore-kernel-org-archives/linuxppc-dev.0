Return-Path: <glikely@secretlab.ca>
Date: Sat, 26 Jul 2008 19:25:47 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080727012547.GG12191@secretlab.ca>
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<4889F299.3080403@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4889F299.3080403@grandegger.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 05:34:49PM +0200, Wolfgang Grandegger wrote:
> Grant Likely wrote:
>> On Fri, Jul 25, 2008 at 5:04 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> I was also thinking to just overtake the U-Boot settings if fdt and dfsrr is
>>> not defined for the I2C node (instead of the debatable default values).
>>
>> This is a perfectly valid option.  Personally, I'd prefer it encoded
>> in the device tree, but if it looks like a valid speed has already
>> been programmed in then I'm cool with the driver just preserving that.
>>  If it turns out to causes problems the we can always change the code
>> to be more conservative later.
>
> How should the Linux driver decide if the registers have been already  
> set by the boot-loader? The reset-values might be good as well.  
> Therefore, if "clock-frequency" is not specified, the driver may simply  
> not touch the fdr and dfsr registers (overtaking the values from the  
> boot-loader).

I'm okay with that.  If the property isn't present then it is probably
okay to just assume that it is usable.

g.
