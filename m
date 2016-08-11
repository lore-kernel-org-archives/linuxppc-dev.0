Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8wKT15WRzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:39:40 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7B4cncs029381
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 00:39:38 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9vmh32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 00:39:38 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 22:39:37 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH 1/4] dt-bindings: add doc for ibm,hotplug-aperture
In-Reply-To: <92e34173-b2e2-bac0-3bbb-fc5407cbb8a5@gmail.com>
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1470680843-28702-2-git-send-email-arbab@linux.vnet.ibm.com>
 <92e34173-b2e2-bac0-3bbb-fc5407cbb8a5@gmail.com>
Date: Thu, 11 Aug 2016 14:39:23 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874m6r2a2s.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:
> On 09/08/16 04:27, Reza Arbab wrote:
>> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
>> ---
>>  .../bindings/powerpc/opal/hotplug-aperture.txt     | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt

Forgive me for being absent on the whole discussion here, but is this an
OPAL specific binding? If so, shouldn't the docs also appear in the
skiboot tree?

-- 
Stewart Smith
OPAL Architect, IBM.
