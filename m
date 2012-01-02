Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D0D6EB6FA4
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jan 2012 03:14:01 +1100 (EST)
Message-ID: <4F01D7C4.1020408@redhat.com>
Date: Mon, 02 Jan 2012 18:13:56 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: Move gfn_to_memslot() to kvm_host.h
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
 <4EF87528.8000305@redhat.com> <6918CBBE-19AF-4323-BFE7-0F8739E32008@suse.de>
In-Reply-To: <6918CBBE-19AF-4323-BFE7-0F8739E32008@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/02/2012 05:23 PM, Alexander Graf wrote:
> > Or we could move the implementation into a header file, with an extra __
> > prefix, and have the C stubs call those inlines, so we have exactly on
> > instantiation.  Your real mode code can then call the inlines.
>
> I like this version. That way everyone should be happy :)

Pretty much how everything is solved.  Pile up another layer of
indirection (compile-time here), everyone's happy, and the code bloats.

(I'm not against this, just grumpy)

-- 
error compiling committee.c: too many arguments to function
