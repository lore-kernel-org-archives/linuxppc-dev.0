Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsY2p4PFCzF1KP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 00:20:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 1/6] powerpc: Add security feature flags for
 Spectre/Meltdown
In-Reply-To: <87606geir8.fsf@linkitivity.dja.id.au>
References: <20180228145316.11347-1-mpe@ellerman.id.au>
 <87606geir8.fsf@linkitivity.dja.id.au>
Date: Fri, 02 Mar 2018 00:20:33 +1100
Message-ID: <871sh47x0e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
>> new file mode 100644
>> index 000000000000..3b690de8b0e8
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/security_features.h
>> @@ -0,0 +1,65 @@
...
>> +// Features indicating support for Spectre/Meltdown mitigations
>> +
>> +// The L1-D cache can be flushed with ori r30,r30,0
>> +#define SEC_FTR_L1D_FLUSH_ORI30		0x0000000000000001ull
>> +
>> +// The L1-D cache can be flushed with mtspr 882,r0 (aka SPRN_TRIG2ull
> This looks like some sort of search-replace gone wrong? ------------^^^^

Sure is! Oops.

Thanks for reviewing.

cheers
