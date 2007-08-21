Return-Path: <matt@genesi-usa.com>
Message-ID: <46CADC61.3050506@genesi-usa.com>
Date: Tue, 21 Aug 2007 13:36:49 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, ppc-dev <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: OF /chosen/initrd,* variables - patch, official?
References: <46CAC89F.2040100@genesi-usa.com> <46CACAAE.5000304@genesi-usa.com>
	<20070821113232.GB1111@localhost.localdomain>
In-Reply-To: <20070821113232.GB1111@localhost.localdomain>
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
> On Tue, Aug 21, 2007 at 12:21:18PM +0100, Matt Sealey wrote:
>> Damn, I should use patchwork more efficiently;
>>
>> http://patchwork.ozlabs.org/linuxppc/patch?q=initrd&filter=none&id=12168
>>
>> Does anyone have any suggestion on the best way to integrate this so that
>> it "just works" on OF platforms? It seems only to be usable way too late
>> in boot to work, this code would have to be called in boot/main.c which seems
>> relatively.. impossible to achieve.. or called in some specialised platform
>> init code..
> 
> It would have to be called from platform_init().  If called in main()
> it would clobber any other platform-specific initialization of the
> initrd parameters in loader_info.

So just to get this straight.. platform_init would be the function called from
md.init or would be better at md.setup_arch?

My goal right now is get something for CHRP (Pegasos) and Efika and try not
to cause problems for anything else, but also really try not to clutter the
thing with config checks, platform checks etc.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
