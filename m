Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkdkz4d9HzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 20:27:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org
Cc: Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>,
 "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, James Morris <james.l.morris@oracle.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 linux-ima-devel@lists.sourceforge.net,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2 0/6] Appended signatures support for IMA appraisal
In-Reply-To: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496886555-10082-1-git-send-email-bauerman@linux.vnet.ibm.com>
Date: Fri, 09 Jun 2017 20:27:03 +1000
Message-ID: <87d1adihhk.fsf@concordia.ellerman.id.au>
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

> On the OpenPOWER platform, secure boot and trusted boot are being
> implemented using IMA for taking measurements and verifying signatures.

I still want you to implement arch_kexec_kernel_verify_sig() as well :)

cheers
