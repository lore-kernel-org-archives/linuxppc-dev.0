Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B76DE2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 02:15:22 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 12:15:20 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D6F88C9004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:15:15 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5JGFFXN172142
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:15:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5JGE50T024367
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 12:14:05 -0400
Date: Wed, 19 Jun 2013 09:13:12 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Runzhen Wang <runzhen@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] perf tools: fix a typo of a Power7 event name
Message-ID: <20130619161312.GA13326@us.ibm.com>
References: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371633326-7696-1-git-send-email-runzhen@linux.vnet.ibm.com>
Cc: acme@redhat.com, icycoder@gmail.com, linux-kernel@vger.kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Runzhen Wang [runzhen@linux.vnet.ibm.com] wrote:
| In the Power7 PMU guide:
| https://www.power.org/documentation/commonly-used-metrics-for-performance-analysis/
| PM_BRU_MPRED is referred to as PM_BR_MPRED.
| 
| This patch fix the typo by changing the name of the event in kernel and
| documentation accordingly.
| 
| Signed-off-by: Runzhen Wang <runzhen@linux.vnet.ibm.com>

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
