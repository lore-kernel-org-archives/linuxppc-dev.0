Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F43B1A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 10:26:21 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 25 Aug 2015 18:26:19 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A0FAC1FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 18:17:25 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q0PHiD39321630
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:25:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q0QFZc030182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 18:26:15 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, j.anaszewski@samsung.com,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH] powerpc/configs: Enable LEDS support
In-Reply-To: <1440489254-8162-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
References: <1440489254-8162-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 10:26:12 +1000
Message-ID: <m3a8teopy3.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> Presently PowerNV LEDS driver is specific to FSP based PowerNV
> platform. Hence added it as 'm'. So that we will be loaded only
> if we have required device tree support.

Currently the *firmware* support is FSP specific.

The driver should magically work on any OPAL machine that hooks up the
OPAL calls and DT. Right?

The A in OPAL is for Abstraction, not P for Passthrough-to-fsp.
