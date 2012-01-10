Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 81D14B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 19:37:22 +1100 (EST)
Message-ID: <4F0BF8BB.4080309@redhat.com>
Date: Tue, 10 Jan 2012 10:37:15 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 16/16] KVM: PPC: e500mc support
References: <20111221013447.GP8378@schlenkerla.am.freescale.net>
 <4F0B16D7.2000709@redhat.com> <4F0B4002.4050407@freescale.com>
In-Reply-To: <4F0B4002.4050407@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Liu Yu <yu.liu@freescale.com>, kvm@vger.kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, Varun Sethi <varun.sethi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/09/2012 09:29 PM, Scott Wood wrote:
> > 
> > Best to include their signoffs, if possible.
>
> These patches are based in part on a bunch of different patches from
> these people (for which I did receive signoffs).  I was reluctant to put
> their signoff directly on the new patches, since I didn't want to make
> it look like they had submitted the patch in anything resembling its
> current form.  I wanted to give them credit for what they did, but not
> blame for what I did with their code.
>

Signoffs are for assigning neither credit nor blame, but for attributing
authorship and affirming that a contributor has the right to contribute
code or pass it along.  Please read the DCO at
https://lwn.net/Articles/437739/.

It's okay to miss them from time to time, especially for established
contributors, but avoid it whenever possible.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
