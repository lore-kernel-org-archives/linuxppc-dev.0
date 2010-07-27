Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id B6EB5B70B5
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 11:57:39 +1000 (EST)
Received: by gxk25 with SMTP id 25so1726373gxk.15
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 18:57:37 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100726.183808.15223674.davem@davemloft.net>
References: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<20100726.154854.35052662.davem@davemloft.net>
	<AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
	<20100726.183808.15223674.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 19:57:17 -0600
Message-ID: <AANLkTi=Kw78W0zuuQ0vzO7rXXVkTDf0D5w8n44hV_FWt@mail.gmail.com>
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

On Mon, Jul 26, 2010 at 7:38 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Mon, 26 Jul 2010 16:51:01 -0600
>
>> Indeed. =A0I looked at it briefly, but it wasn't immediately clear what
>> the impact would be to switch powerpc over to -1, and it looked to me
>> like sparc depends on -1 to signify no node association.
>
> Kernel wide, NUMA interfaces tend to take "-1" to mean "any node."
>
> I had looked over the powerpc cases, and besides 1 or 2 strange
> locations the powerpc call sites were ready to handle -1.

Okay, well let me rework the patch to make -1 the default and let
powerpc override it.  A follow-on patch can fix up the powerpc usage
of 0.

g.
