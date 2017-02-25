Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVXQL2zrkzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 13:45:29 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1P2hdNr095610
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 21:45:27 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ty6kuf0c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 21:45:27 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 19:45:26 -0700
Date: Sat, 25 Feb 2017 08:15:19 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc: kretprobes: override default function
 entry offset
Reply-To: ananth@linux.vnet.ibm.com
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e27a624a724f1b00d09e769cbce24abdb27d8688.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170225024519.GE24324@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2017 at 07:23:38PM +0530, Naveen N. Rao wrote:
> With ABIv2, we offset 8 bytes into a function to get at the local entry
> point.
> 

Looks good.

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
