Return-Path: <albert_herranz@yahoo.es>
Received: from smtp112.mail.ukl.yahoo.com (smtp112.mail.ukl.yahoo.com
	[77.238.184.50]) by ozlabs.org (Postfix) with SMTP id 3C7B4B7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:56:20 +1100 (EST)
Message-ID: <4B0AE8E3.7050606@yahoo.es>
Date: Mon, 23 Nov 2009 20:56:19 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221520i22372282j6b619828c198d184@mail.gmail.com>
In-Reply-To: <fa686aa40911221520i22372282j6b619828c198d184@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> Add a config option GAMECUBE_COMMON to be used as a dependency for all
>> options common to the Nintendo GameCube and Wii video game consoles.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> This could just be rolled into the first patch that uses it.  But
> otherwise; ACK.
> 
> g.
> 

Thanks. This one I prefer in a separate patch as a logical step, if that's not a problem.

>> ---
>>  arch/powerpc/platforms/embedded6xx/Kconfig |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
>> index 291ac9d..97a2dbc 100644
>> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
>> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
>> @@ -90,3 +90,7 @@ config MPC10X_OPENPIC
>>  config MPC10X_STORE_GATHERING
>>        bool "Enable MPC10x store gathering"
>>        depends on MPC10X_BRIDGE
>> +
>> +config GAMECUBE_COMMON
>> +       bool
>> +

Cheers,
Albert
