Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkWqD3CbyzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 12:59:04 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q129so401793pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 19:59:04 -0700 (PDT)
Date: Tue, 12 Apr 2016 10:58:59 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>,
 Simon Guo <simonguo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [RESEND][PATCH v2] powerpc: Export
 thread_struct.used_vr/used_vsr to user space
Message-ID: <20160412025859.GB7322@simonLocalRHEL7.x64>
References: <20160406070012.GA11647@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160406070012.GA11647@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
On Wed, Apr 06, 2016 at 03:00:12PM +0800, Simon Guo wrote:
> These 2 fields track whether user process has used Altivec/VSX
> registers or not. They are used by kernel to setup signal frame
> on user stack correctly regarding vector part.
> 
> CRIU(Checkpoint and Restore In User space) builds signal frame
> for restored process. It will need this export information to
> setup signal frame correctly. And CRIU will need to restore these
> 2 fields for the restored process.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---

Is there any chance that this patch can be merged upstream soon? 
The corresponding work of CRIU has to follow after that.

Thanks,
Simon
