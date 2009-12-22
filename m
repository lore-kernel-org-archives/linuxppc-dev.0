Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 290BEB7B71
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 06:21:45 +1100 (EST)
Message-ID: <4B311C13.6010903@grandegger.com>
Date: Tue, 22 Dec 2009 20:20:51 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: I2C bus clock on MPC85XX systems
References: <4B30E7F5.8080201@embedded-sol.com>	<4B30F165.2060300@grandegger.com>	<4B310D10.4090307@embedded-sol.com>
	<4B311281.6020801@grandegger.com>
	<4B3118A9.6000704@embedded-sol.com>
In-Reply-To: <4B3118A9.6000704@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felix,

Felix Radensky wrote:
> Hi, Wolfgang
> 
> Wolfgang Grandegger wrote:
[snip]
>> The trees provided by Freescale are usually based on older kernel
>> version. Borrow from such trees is OK, but the project developers should
>> use a recent kernel version for development.
>>   
> 
> I was talking about modern vanilla kernels for Freescale reference
> boards. See, for example
> http://lxr.linux.no/#linux+v2.6.32/arch/powerpc/boot/dts/mpc8536ds.dts

Only a few boards use these new properties to set a reasonable I2C
clock. But I agree, adding "clock-frequency = <100000>;" would make it
more obvious to the users how to define a proper frequency.

Wolfgang.
