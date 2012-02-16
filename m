Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 4A34FB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 03:09:42 +1100 (EST)
Message-ID: <4F3D2A3C.9060902@redhat.com>
Date: Thu, 16 Feb 2012 18:09:32 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: [PATCH] arch/powerpc/kvm/book3s_hv.c: included linux/sched.h twice
References: <1329400554-31904-1-git-send-email-danny.kukawka@bisect.de>
In-Reply-To: <1329400554-31904-1-git-send-email-danny.kukawka@bisect.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Danny Kukawka <dkukawka@suse.de>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2012 03:55 PM, Danny Kukawka wrote:
> arch/powerpc/kvm/book3s_hv.c: included 'linux/sched.h' twice,
> remove the duplicate.
>

Thanks, applied.

-- 
error compiling committee.c: too many arguments to function
