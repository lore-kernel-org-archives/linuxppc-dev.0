Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D1318B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 03:33:35 +1100 (EST)
Message-ID: <4F0B16D7.2000709@redhat.com>
Date: Mon, 09 Jan 2012 18:33:27 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 16/16] KVM: PPC: e500mc support
References: <20111221013447.GP8378@schlenkerla.am.freescale.net>
In-Reply-To: <20111221013447.GP8378@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/21/2011 03:34 AM, Scott Wood wrote:
> Add processor support for e500mc, using hardware virtualization support
> (GS-mode).
>
> Current issues include:
>  - No support for external proxy (coreint) interrupt mode in the guest.
>
> Includes work by Ashish Kalra <Ashish.Kalra@freescale.com>,
> Varun Sethi <Varun.Sethi@freescale.com>, and
> Liu Yu <yu.liu@freescale.com>.
>

Best to include their signoffs, if possible.

-- 
error compiling committee.c: too many arguments to function
