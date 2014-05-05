Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2004514031E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 21:38:33 +1000 (EST)
Message-ID: <53677834.5010808@suse.de>
Date: Mon, 05 May 2014 13:38:28 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

No patch description, no proper explanations anywhere why you're doing 
what. All of that in a pretty sensitive piece of code. There's no way 
this patch can go upstream in its current form.


Alex
