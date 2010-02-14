Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176]) by ozlabs.org (Postfix) with ESMTP id 7B6FEB7CF2
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 01:06:49 +1100 (EST)
Received: by yxe6 with SMTP id 6so4060012yxe.11
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 06:06:48 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1266127834.16346.60.camel@pasglop>
References: <20100213154838.4767.83881.stgit@angua>
	<20100213160242.4767.57641.stgit@angua>
	<1266127834.16346.60.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 14 Feb 2010 07:06:28 -0700
Message-ID: <fa686aa41002140606s798f356ft6dcea472f7076bdd@mail.gmail.com>
Subject: Re: [PATCH 3/9] of: protect linux/of.h with CONFIG_OF
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 13, 2010 at 11:10 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-02-13 at 09:02 -0700, Grant Likely wrote:
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
>>
>> For platforms that have CONFIG_OF optional, we need to make the contents
>> of linux/of.h conditional on CONFIG_OF.
>>
>> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> For now...
>
> In the long run, maybe we want some of the iterators to be empty inlines
> returning NULL ?

Yes.  I'll add them as they are needed.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
