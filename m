Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8D502C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 01:38:51 +1100 (EST)
Received: by mail-wi0-f173.google.com with SMTP id hm2so3559043wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 06:38:46 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] Add /proc device tree updating to of node add/remove
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 devicetree-discuss@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <506BA905.4090000@linux.vnet.ibm.com>
References: <506B2E63.5090900@linux.vnet.ibm.com>
 <506BA905.4090000@linux.vnet.ibm.com>
Date: Wed, 14 Nov 2012 14:38:27 +0000
Message-Id: <20121114143827.19DB73E0AA8@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 02 Oct 2012 21:55:01 -0500, Nathan Fontenot <nfont@linux.vnet.ibm.com> wrote:
> When adding or removing a device tree node we should also update
> the device tree in /proc/device-tree. This action is already done in the
> generic OF code for adding/removing properties of a node. This patch adds
> this functionality for nodes.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com> 

For the whole series:

Acked-by: Grant Likely <grant.likely@secretlab.ca>
