Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C6DB5B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 22:05:43 +1000 (EST)
Message-ID: <4C20A713.4010304@redhat.com>
Date: Tue, 22 Jun 2010 15:05:39 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Make BAT only guest segments work
References: <1277126695-32081-1-git-send-email-agraf@suse.de>
In-Reply-To: <1277126695-32081-1-git-send-email-agraf@suse.de>
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

On 06/21/2010 04:24 PM, Alexander Graf wrote:
> When a guest sets its SR entry to invalid, we may still find a
> corresponding entry in a BAT. So we need to make sure we're not
> faulting on invalid SR entries, but instead just claim them to be
> BAT resolved.
>
> This resolves breakage experienced when using libogc based guests.
>    

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
