Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE00D2C0302
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 09:39:52 +1000 (EST)
Message-ID: <503FF9E9.4020701@wwwdotorg.org>
Date: Thu, 30 Aug 2012 16:40:25 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] clk: Make the generic clock API available by default
References: <1346186104-4083-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <503E8E6E.1010101@wwwdotorg.org>
 <20120830171918.GE4356@opensource.wolfsonmicro.com>
In-Reply-To: <20120830171918.GE4356@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Paul Mackerras <paulus@samba.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/12 10:19, Mark Brown wrote:
> On Wed, Aug 29, 2012 at 02:49:34PM -0700, Stephen Warren wrote:
>> On 08/28/12 13:35, Mark Brown wrote:
>
>>> @@ -674,6 +676,7 @@ config ARCH_TEGRA
>>>   	select GENERIC_CLOCKEVENTS
>>>   	select GENERIC_GPIO
>>>   	select HAVE_CLK
>>> +	select HAVE_CUSTOM_CLK
>
>> For 3.7, Tegra will switch to the common clock framework. I think
>> this patch would then disable that. How should we resolve this -
>> rebase the Tegra common-clk tree on top of any branch containing
>> this patch in order to remove that select statement?
>
> I'd expect this to be applied on a separate branch so you should be able
> to rebase your conversion on top of it or merge it into your branch
> which should deal with things well enough I think?

That should work.
