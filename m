Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn5Md0rlTzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:18:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, Jessica Yu <jeyu@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Howells <dhowells@redhat.com>, "AKASHI\,
 Takahiro" <takahiro.akashi@linaro.org>, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, James Morris <james.l.morris@oracle.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-ima-devel@lists.sourceforge.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 0/6] Appended signatures support for IMA appraisal
In-Reply-To: <87efusyi3s.fsf@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <87d1adihhk.fsf@concordia.ellerman.id.au> <87efusyi3s.fsf@linux.vnet.ibm.com>
Date: Tue, 13 Jun 2017 20:18:51 +1000
Message-ID: <87tw3kgph0.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>>
>>> On the OpenPOWER platform, secure boot and trusted boot are being
>>> implemented using IMA for taking measurements and verifying signatures.
>>
>> I still want you to implement arch_kexec_kernel_verify_sig() as well :)
>
> Yes, I will implement it! We are still working on loading the public
> keys for kernel signing from the firmware into a kernel keyring, so
> there's not much point in implementing arch_kexec_kernel_verify_sig
> without having that first.

OK. What's the ETA on those patches?

cheers
