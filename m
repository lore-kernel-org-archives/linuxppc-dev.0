Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 436DFDE3D0
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 12:04:55 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2317571yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jan 2009 17:04:54 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <4962AE34.3030707@genesi-usa.com>
Date: Mon, 05 Jan 2009 19:04:52 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Subject: Re: yaboot: text mode or graphics mode?
References: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>	
	<d2b9ccd90812200956jee5279ak68776aec20fb8b80@mail.gmail.com>	
	<495AA4A7.409@genesi-usa.com>
	<d2b9ccd90901042131v2b00bd0bld7009e8d865bd9c7@mail.gmail.com>
In-Reply-To: <d2b9ccd90901042131v2b00bd0bld7009e8d865bd9c7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

They should be mapped into PCI address space with the rest, you should 
note though that a bunch of people have asked this a bunch of times and 
the response is usually null.

If you want to output debugging info, try a serial port, or if you're 
still at the point in boot where the OF is still around, you can still 
output to it (check prom_init.c) and if not, the open firmware 
framebuffer console driver is your best friend..

sumedh tirodkar wrote:
> Isn't there any other way that i can access the VGA registers? So as
> to reconfigure them...
> 
> -Sumedh
> 
> On Wed, Dec 31, 2008 at 4:15 AM, Matt Sealey <matt@genesi-usa.com> wrote:
>> sumedh tirodkar wrote:
>>> I just found out that openfirmware boots into graphics mode(non-text
>>> mode). Now i wish to switch back to text mode. how do i do this?
>> Unfortunately unless you are running some kind of yaboot-accessible or
>> firmware-accessible x86 BIOS emulation, this isn't possible.
>>
>> --
>> Matt
>>
