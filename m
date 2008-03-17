Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.229])
	by ozlabs.org (Postfix) with ESMTP id A31D2DDF4D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:23:08 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4972471wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 13:23:06 -0700 (PDT)
Message-ID: <fa686aa40803171323r2e73e53xd01d0590efccbf90@mail.gmail.com>
Date: Mon, 17 Mar 2008 14:23:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/3] Xilinx: hwicap: Refactor status handling code.
In-Reply-To: <20080317173644.C24651C00069@mail59-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1205775392-32222-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080317173644.C24651C00069@mail59-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev@xilinx.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 11:36 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Both the buffer-based and fifo-based icap cores have a status
>  register.  Previously, this was only used internally to check whether
>  transactions have completed.  However, the status can be useful to the
>  main driver as well.  This patch exposes these status functions to the
>  main driver along with some masks for the differnet bits.
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
