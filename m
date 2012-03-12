Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2BB3B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 06:29:12 +1100 (EST)
Subject: Re: [PATCH v2 1/2] powerpc/e500: make load_up_spe a normal fuction
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F5795FC.4000803@freescale.com>
Date: Mon, 12 Mar 2012 20:29:05 +0100
Message-Id: <1F936E46-0CFC-4C0A-A7A8-EF05C8AFCE49@suse.de>
References: <1330564819-11139-1-git-send-email-hong-hua.yin@freescale.com>
 <4F57691E.1070105@suse.de> <4F5795FC.4000803@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "kvm@vger.kernel.org list" <kvm@vger.kernel.org>,
 Olivia Yin <hong-hua.yin@freescale.com>,
 Tabi Timur-B04825 <B04825@freescale.com>, kvm-ppc@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.03.2012, at 18:08, Scott Wood wrote:

> On 03/07/2012 07:56 AM, Alexander Graf wrote:
>> On 03/01/2012 02:20 AM, Olivia Yin wrote:
>>> From: Liu Yu<yu.liu@freescale.com>
>>> 
>>> So that we can call it when improving SPE switch like book3e did for
>>> fp switch.
>> 
>> Timur / Scott, can you please (n)ack this one?
> 
> ACK, though as it touches non-KVM code it'd be nice to get an ack from
> Kumar.

Kumar, ping?
