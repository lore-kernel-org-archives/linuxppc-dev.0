Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id B2094B6F3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:04:44 +1000 (EST)
Message-ID: <4C20A6D9.20005@redhat.com>
Date: Tue, 22 Jun 2010 15:04:41 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Use kernel hash function
References: <1277126719-32150-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277126719-32150-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2010 04:25 PM, Alexander Graf wrote:
> The linux kernel already provides a hash function. Let's reuse that
> instead of reinventing the wheel!
>    

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
