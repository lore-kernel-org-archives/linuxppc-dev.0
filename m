Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402zNv4GtszF1W9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 08:38:55 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2GLYnIm012934
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 17:38:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2grk2fnt21-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 17:38:52 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 16 Mar 2018 15:38:51 -0600
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 David Howells <dhowells@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 00/12] Appended signatures support for IMA appraisal
In-reply-to: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 18:38:38 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zi37og4h.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Now the modsig is only ignored if it references a signature that is not
> present in IMA's keyring (or if there's a parsing error, obviously). If the

The above should read "Now the modsig is only ignored if it references a
*key* that is not present in IMA's keyring".

Sorry, I only noticed the mistake after sending the emails.

--
Thiago Jung Bauermann
IBM Linux Technology Center
