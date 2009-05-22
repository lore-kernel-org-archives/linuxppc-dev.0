Return-Path: <wg@grandegger.com>
Message-ID: <4A16BAFE.7090401@grandegger.com>
Date: Fri, 22 May 2009 16:47:26 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [net-next-2.6 PATCH] can: SJA1000: generic OF platform bus driver
References: <4A143896.7050200@grandegger.com>	<fa686aa40905212142n4a8c3caamb2f28eef036e3922@mail.gmail.com>
	<20090521.233123.135354184.davem@davemloft.net>
In-Reply-To: <20090521.233123.135354184.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Thu, 21 May 2009 22:42:07 -0600
> 
>> On Wed, May 20, 2009 at 11:06 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> This patch adds a generic driver for SJA1000 chips on the OpenFirmware
>>> platform bus found on embedded PowerPC systems. You need a SJA1000 node
>>> definition in your flattened device tree source (DTS) file similar to:
>>>
>>>   can@3,100 {
>>>           compatible = "philips,sja1000";
>>>           reg = <3 0x100 0x80>;
>>>           clock-frequency = <8000000>;
>>>           cdr-reg = <0x48>;
>>>           ocr-reg = <0x0a>;
>>>           interrupts = <2 0>;
>>>           interrupt-parent = <&mpic>;
>>>   };
>> This new binding must be documented in Documentation/powerpc/dts-bindings
> 
> Wolfgang, please add this documentation and resubmit your patch.
> Thanks!

I just sent out v2 incuding the missing documentation.

Thanks,

Wolfgang.
