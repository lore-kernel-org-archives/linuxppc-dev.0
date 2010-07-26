Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id C9BC0B70CA
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 08:51:22 +1000 (EST)
Received: by yxi11 with SMTP id 11so404743yxi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 15:51:21 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100726.154854.35052662.davem@davemloft.net>
References: <20100726220405.1550.63442.stgit@angua>
	<20100726222627.GA23501@merkur.ravnborg.org>
	<AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<20100726.154854.35052662.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:51:01 -0600
Message-ID: <AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
	of_node_to_nid()
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, sam@ravnborg.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 26, 2010 at 4:48 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Mon, 26 Jul 2010 16:42:20 -0600
>
>> It protects against some later include file doing a #define
>> of_node_to_nid and thus resulting in an inconsistent definition. =A0If
>> some code tries to do this then the preprocessor will complain. =A0This
>> is the pattern that Stephen suggested.
>
> Also, it would be nice to unravel the "0" vs. "-1" default
> inconsistency.

Indeed.  I looked at it briefly, but it wasn't immediately clear what
the impact would be to switch powerpc over to -1, and it looked to me
like sparc depends on -1 to signify no node association.

g.
