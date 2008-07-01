Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 1D178DDF46
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 03:06:33 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so408898yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 10:06:32 -0700 (PDT)
Date: Tue, 1 Jul 2008 11:06:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't used
Message-ID: <20080701170628.GA10912@secretlab.ca>
References: <12149299143952-git-send-email-john.linn@xilinx.com>
	<977C41F842E66D4CB2E41332313B6150062A2DB4@XSJ-EXCHVS1.xlnx.xilinx.com>
	<20080701165222.991255E0054@mail197-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080701165222.991255E0054@mail197-dub.bigfish.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, dwg@au1.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 01, 2008 at 10:52:20AM -0600, John Linn wrote:
> It could be "||" but I didn't know if there were cases where that
> wouldn't be true. I don't know that code that well so I was being
> conservative and maybe shouldn't be. 

No, Stephen is right.  It should be ||

g.
