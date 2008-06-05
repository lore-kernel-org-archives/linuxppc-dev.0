Return-Path: <wg@grandegger.com>
Message-ID: <48484EFE.5050101@grandegger.com>
Date: Thu, 05 Jun 2008 22:39:26 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <48481E86.1060302@grandegger.com>
	<4188A8A4-BDF9-4D23-A874-19C6A9A18E71@kernel.crashing.org>
In-Reply-To: <4188A8A4-BDF9-4D23-A874-19C6A9A18E71@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
>> ===================================================================
>> --- /dev/null
>> +++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8548.dts
>>
> 
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x00000000 0x20000000>;
>> +    };
> 
> is memory fixed on this board to 256M?

Ah, no, actually I have a module with 512 MB but it can be ordered with
less or more memory like the other TQM85xx modules as well. Does U-Boot
fixup this value? Is it used by Linux?

> just let me know and I can fix when I commit it.

That would be great... thanks.

Wolfgang.
