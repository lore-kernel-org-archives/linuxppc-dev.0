Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMwsT75R4zDqQl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 19:42:37 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E8Su1G034205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:42:35 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kv2dp0hq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 03:42:35 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 01:42:34 -0700
Date: Tue, 14 Feb 2017 14:12:28 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: kprobes: factor out code to emulate
 instruction into a helper
Reply-To: ananth@linux.vnet.ibm.com
References: <1b7d5ea08a7e11fbf1fb08dd3536219c94b13591.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
 <f7c2116b556de0a764e1c7c5369c13fc9139566b.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f7c2116b556de0a764e1c7c5369c13fc9139566b.1487060527.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170214084228.GH29806@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2017 at 02:08:02PM +0530, Naveen N. Rao wrote:
> This helper will be used in a subsequent patch to emulate instructions
> on re-entering the kprobe handler. No functional change.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
