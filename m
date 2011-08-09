Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 7580EB6F8F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:42:55 +1000 (EST)
Message-ID: <4E41638A.2010707@redhat.com>
Date: Tue, 09 Aug 2011 19:42:50 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 00/10] PAPR virtualization on PR KVM
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 07:31 PM, Alexander Graf wrote:
> In KVM for Book3S PPC we currently have 2 implementations. There
> is the PR based implementation which works on any POWER system
> you pass in and the super fast HV implementation which requires
> libre firmware (so almost nobody can use it).

Did you mean, non-libre?

>
> Currently, the two target two different machine types, with PR KVM
> being used for bare metal system virtualization, while the HV KVM
> is used to virtualize PAPR.
>
> In an effort to make things more cozy and transparent to the user,
> this patch set implements PAPR capabilities to the PR KVM side, so
> a user doesn't have to worry what the respective kernel module
> supports. Any machine he's virtualizing "just works".
>

Nice.  I went though it and nothing shouted "I'm wrong, kill me please", 
though I don't claim to understand more than 5% of it.

-- 
error compiling committee.c: too many arguments to function
