Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id EE85567B56
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 07:26:58 +1000 (EST)
Date: Fri, 11 Aug 2006 16:26:49 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Message-ID: <20060811212649.GN3233@localdomain>
References: <44D99F1A.4080905@de.ibm.com> <20060811211915.GL3233@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811211915.GL3233@localdomain>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:

> Hope all the callers of this function are in non-atomic context (but I
> wasn't able to find any callers?).

Never mind, I somehow missed the users of ehea_hcall_9arg_9ret in this
patch, sorry.
