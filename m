Return-Path: <ananth@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82D082C0156
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2012 21:34:13 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Mon, 10 Dec 2012 03:34:10 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F0B591FF001C
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2012 03:34:00 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBAAY6CC310694
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2012 03:34:07 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBAAY5qA020662
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2012 03:34:06 -0700
Date: Mon, 10 Dec 2012 16:04:03 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH v2 2/4] powerpc: Move the single step enable code to a
 generic path
Message-ID: <20121210103403.GA31751@in.ibm.com>
References: <20121203150438.7727.74924.stgit@suzukikp>
 <20121203150754.7727.42629.stgit@suzukikp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121203150754.7727.42629.stgit@suzukikp>
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org, bigeasy@linutronix.de,
 oleg@redhat.com, linuxppc-dev@ozlabs.org, anton@redhat.com, mingo@elte.hu,
 linux-kernel@vger.kernel.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2012 at 08:38:37PM +0530, Suzuki K. Poulose wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> This patch moves the single step enable code used by kprobe to a generic
> routine header so that, it can be re-used by other code, in this case,
> uprobes. No functional changes.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc:	Ananth N Mavinakaynahalli <ananth@in.ibm.com>
> Cc:	Kumar Gala <galak@kernel.crashing.org>
> Cc:	linuxppc-dev@ozlabs.org

Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
