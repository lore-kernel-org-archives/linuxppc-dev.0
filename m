Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 10CCD68343
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2005 12:24:26 +1000 (EST)
In-Reply-To: <20050918224955.GA5739@mars>
References: <Pine.LNX.4.61.0509181301340.19087@nylon.am.freescale.net>
	<20050918224955.GA5739@mars>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E43BD333-0C7E-4751-8A9D-0F7234114E68@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 18 Sep 2005 21:24:46 -0500
To: "<a.othieno@bluewin.ch>" <a.othieno@bluewin.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Allow user to individual select CHRP/PMAC/PREP
	config
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, good catch.  I'll send an updated patch that gets ride of the  
duplicated 'bool's.

- kumar

On Sep 18, 2005, at 5:49 PM, <a.othieno@bluewin.ch>  
<a.othieno@bluewin.ch> wrote:

> On Sun, Sep 18, 2005 at 01:02:03PM -0500, Kumar Gala wrote:
>
>> Made the CHRP/PMAC/PREP config options selectable by the user.
>> This allows us to build kernels specifically for one of the
>> platforms thus reducing code size.
>>
>> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>>
>> ---
>> commit 41bfc892910fa820db2dfcaf876b2cbc2e3c4e56
>> tree 2f77679b39af1f36174ada8338ad267858e46024
>> parent e08f933110ff9e7d1a4b4e0ccead28e47c6840ea
>> author Kumar K. Gala <kumar.gala@freescale.com> Sun, 18 Sep 2005
>>
> 13:01:02 -0500
>
>> committer Kumar K. Gala <kumar.gala@freescale.com> Sun, 18 Sep 2005
>>
> 13:01:02 -0500
>
>>
>>  arch/ppc/Kconfig |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
>> --- a/arch/ppc/Kconfig
>> +++ b/arch/ppc/Kconfig
>> @@ -747,12 +747,13 @@ config CPM2
>>        on it (826x, 827x, 8560).
>>
>>  config PPC_CHRP
>> +    bool "  Common Hardware Reference Platform (CHRP) based
>>
> machines"
>
>>      bool
>>
>
> Forgot to knock off that extra `bool' ?
>
>
>>      depends on PPC_MULTIPLATFORM
>>      default y
>>
>>  config PPC_PMAC
>> -    bool
>> +    bool "  Apple PowerMac based machines"
>>      depends on PPC_MULTIPLATFORM
>>      default y
>>
>> @@ -762,6 +763,7 @@ config PPC_PMAC64
>>      default y
>>
>>  config PPC_PREP
>> +    bool "  PowerPC Reference Platform (PREP) based machines"
>>      bool
>>
>
> Ditto.
>
>
>>      depends on PPC_MULTIPLATFORM
>>      default y
>
