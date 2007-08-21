Return-Path: <matt@genesi-usa.com>
Message-ID: <46CAF5B4.9040606@genesi-usa.com>
Date: Tue, 21 Aug 2007 15:24:52 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: OF /chosen/initrd,* variables - patch, official?
References: <46CAC89F.2040100@genesi-usa.com> <46CACAAE.5000304@genesi-usa.com>
	<20070821113232.GB1111@localhost.localdomain>
	<46CADC61.3050506@genesi-usa.com>
	<20070821124253.GC1111@localhost.localdomain>
	<46CAE177.3010508@genesi-usa.com>
	<20070821135449.GA7438@localhost.localdomain>
In-Reply-To: <20070821135449.GA7438@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Aug 21, 2007 at 01:58:31PM +0100, Matt Sealey wrote:
>> David Gibson wrote:
>>> Uh... no... this is in the bootwrapper, long before ppc_md even
>>> exists.  platform_init() is called from arch/powerpc/boot/crt0.S,
>>> immediately before main().
>> Oh *THAT* platform init.
>>
>> So I could just drop a
>>
>> } else {
>> 	dt_find_initrd();
>> }
>>
>> .. at the end and nobody would be too disgusted or have any problems?
> 
> Err.. at the end of what?  Each platform has it's own version of
> platform_init().

arch/powerpc/boot/of.c since it's not really relevant to me for non-OF
platforms?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
