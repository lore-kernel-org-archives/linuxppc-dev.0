Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B25E1A10AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2015 11:40:14 +1100 (AEDT)
Date: Thu, 10 Dec 2015 11:39:14 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Geyslan G. Bem" <geyslan@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: remove unused variable 'vcpu_book3s'
Message-ID: <20151210003914.GB6978@fergus.ozlabs.ibm.com>
References: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 01, 2015 at 08:42:10PM -0300, Geyslan G. Bem wrote:
> The vcpu_book3s struct is assigned but never used. So remove it.
> 
> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
