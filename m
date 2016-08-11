Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9FxQ1g4FzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 03:53:29 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BHnNCT064663
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:53:27 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9uwevn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:53:27 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 11:53:26 -0600
Date: Thu, 11 Aug 2016 12:53:11 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH 1/4] dt-bindings: add doc for ibm,hotplug-aperture
References: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1470680843-28702-2-git-send-email-arbab@linux.vnet.ibm.com>
 <92e34173-b2e2-bac0-3bbb-fc5407cbb8a5@gmail.com>
 <874m6r2a2s.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <874m6r2a2s.fsf@linux.vnet.ibm.com>
Message-Id: <20160811175311.GD12039@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 02:39:23PM +1000, Stewart Smith wrote:
>Forgive me for being absent on the whole discussion here, but is this 
>an OPAL specific binding? If so, shouldn't the docs also appear in the
>skiboot tree?

Good question. I guess it's not necessarily OPAL-specific, even though 
OPAL may initially be the only implementor of the binding.

Would it be more appropriate to move the file up a directory, directly 
under Documentation/devicetree/bindings/powerpc? I hesitated at that 
because the binding is tied to "ibm,associativity".

-- 
Reza Arbab
