Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 0F1A8B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 02:42:45 +1000 (EST)
Message-ID: <4C715382.6050809@redhat.com>
Date: Sun, 22 Aug 2010 19:42:42 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 13/26] KVM: PPC: Add feature bitmap for magic page
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
	<1282053481-18787-14-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-14-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 08/17/2010 04:57 PM, Alexander Graf wrote:
> We will soon add SR PV support to the shared page, so we need some
> infrastructure that allows the guest to query for features KVM exports.
>
> This patch adds a second return value to the magic mapping that
> indicated to the guest which features are available.
>

You need to make that feature controllable from userspace, to allow 
new->old save/restore.

-- 
error compiling committee.c: too many arguments to function
