Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8AB1B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 00:54:03 +1100 (EST)
Message-ID: <4F576876.8030807@suse.de>
Date: Wed, 07 Mar 2012 14:53:58 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Yin Olivia-R63875 <r63875@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/e500: make load_up_spe a normal fuction
References: <1330340388-30296-1-git-send-email-hong-hua.yin@freescale.com>
 <4F4BD726.1030805@freescale.com>
 <B5012D5F6E2BBC4DBF16B3E6037A5B7316CCE0@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <B5012D5F6E2BBC4DBF16B3E6037A5B7316CCE0@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2012 08:09 AM, Yin Olivia-R63875 wrote:
> Hi Scott,
>
> This had been reviewed before and accepted by internal tree.
> http://linux.freescale.net/patchwork/patch/11100/
> http://git.am.freescale.net/gitolite/gitweb.cgi/sdk/kvm.git/commit/?h=for-sdk1.2&id=c5088844dc665dbdae4fa51b8d58dc203bacc17e
>
> I didn't change anything except the line.
> I just commit to external kvm-ppc mailing list. Should I add my own Signed-off-by?

Yes, if you just take a patch from someone else and direct it to another 
tree, you keep the From: line (git cherry-pick or git am should do that 
automatically for you) and add your own SOB-line (git am -s can do that 
for example).

Since you're also supposed to change the description, please note that 
between Yu's SOB line and your SOB line with something like

Signed-off-by: Liu Yu<yu.liu@freescale.com>
[olivia: change description]
Signed-off-by: Olivia Yin<r63875@freescale.com>



Alex
