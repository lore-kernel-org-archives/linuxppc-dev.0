Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A838DB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:28:24 +1000 (EST)
Subject: Re: [openmcapi-dev] [PATCH] powerpc: Exporting boot_cpuid_phys
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E29CB58.10103@mentor.com>
Date: Fri, 22 Jul 2011 15:28:11 -0500
Message-Id: <02ECB062-7A50-4D9D-AD5D-9567A74C041B@kernel.crashing.org>
References: <4E219085.8000709@mentor.com> <4E29CB58.10103@mentor.com>
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: openmcapi-dev@googlegroups.com,
	Andrew Gabbasov <andrew_gabbasov@mentor.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2011, at 2:11 PM, Hollis Blanchard wrote:

> On 07/16/2011 06:22 AM, Andrew Gabbasov wrote:
>> Kernel loadable module can use hard_smp_processor_id() if building =
with SMP
>> kernel. In order to make it work for UP kernels too, boot_cpuid_phys
>> symbol (which is what hard_smp_processor_id() macro resolves to
>> in non-SMP configuration) must be exported.
>>=20
>> Signed-off-by: Andrew Gabbasov<andrew_gabbasov@mentor.com>
>> ---
>>  arch/powerpc/kernel/setup_32.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/setup_32.c =
b/arch/powerpc/kernel/setup_32.c
>> index 1d2fbc9..3dffce6 100644
>> --- a/arch/powerpc/kernel/setup_32.c
>> +++ b/arch/powerpc/kernel/setup_32.c
>> @@ -49,6 +49,7 @@ extern void bootx_init(unsigned long r4, unsigned =
long phys);
>>  int boot_cpuid =3D -1;
>>  EXPORT_SYMBOL_GPL(boot_cpuid);
>>  int boot_cpuid_phys;
>> +EXPORT_SYMBOL_GPL(boot_cpuid_phys);
>>=20
>>  int smp_hw_index[NR_CPUS];
>=20
> Ben, ping?

Its in Benh's next branch.

- k=
