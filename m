Return-Path: <carlos@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 776712C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 11:57:03 +1100 (EST)
Message-ID: <528EABCF.4090301@redhat.com>
Date: Thu, 21 Nov 2013 19:56:47 -0500
From: "Carlos O'Donell" <carlos@redhat.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/signals: Mark VSX not saved with small contexts
References: <1384924734-16722-1-git-send-email-mikey@neuling.org>
 <20131121113333.GB15913@concordia> <528E2EB6.2010003@redhat.com>
 <8900.1385072483@ale.ozlabs.ibm.com> <528EAAEE.8070300@redhat.com>
In-Reply-To: <528EAAEE.8070300@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steve Best <sbest@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2013 07:53 PM, Carlos O'Donell wrote:
> The addition of the *context functions in glibc for 64-bit power
> happened in 2003 by glibc commit 609b4783, with the mcontext_t
> being expanded to include 

... support for VMX state via `long vmx_reserve[NVRREG+NVRREG+1];'.

Cheers,
Carlos.
