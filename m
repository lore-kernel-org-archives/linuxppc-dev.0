Return-Path: <dan.j.williams@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id D0962B6EE9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 09:47:51 +1100 (EST)
Message-ID: <4B296394.9010709@intel.com>
Date: Wed, 16 Dec 2009 15:47:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
	<2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
In-Reply-To: <2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"B04825@freescale.com" <B04825@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Vishnu Suresh <Vishnu@freescale.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Dipen Dudhat <Dipen.Dudhat@freescale.com>,
	Maneesh Gupta <Maneesh.Gupta@freescale.com>,
	"R58472@freescale.com" <R58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>>> Changes with respect to v1 as per comments received
>>> o. Rebased to linux-next as of 20091216
>>> o. The selection is based exclusive of fsldma
>>> o. Intoduced a new Kernel Configuration variable
>>>   *. This enables selecting the Cryptographic functionality
>>>      of Talitos along with fsldma.
>>>   *. Disables the XOR parity calculation offload, if fsldma enabled
>>>      either as kernel in-built or as a module
>>>   *. Once the inter-operability with fsldma is resolved, this option
>>>      can be removed
>> wait, why can't the interoperability bug be fixed in the first place?
> 
> I agree w/Kim.  We need to better understand what the bug is and how to reproduce it so we can get to the root cause.
> 
> Paper taping over it by disabling fsldma is not the right solution.

Hopefully this prompts fsldma authors to get involved because the 
interoperability issue has been out there without comment*, just 
band-aids, since October.

--
Dan

* well one comment from Ira saying the interrupt functionality worked 
for him.
