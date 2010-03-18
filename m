Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f197.google.com (mail-yx0-f197.google.com
	[209.85.210.197]) by ozlabs.org (Postfix) with ESMTP id 194E1B7FF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 04:07:56 +1100 (EST)
Received: by yxe35 with SMTP id 35so1281563yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Mar 2010 10:07:55 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100318125939.2b39d7f2@lappy.seanm.ca>
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
	<20100318125939.2b39d7f2@lappy.seanm.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Mar 2010 11:07:35 -0600
Message-ID: <fa686aa41003181007k9202cd6n44d2d3997ef626a1@mail.gmail.com>
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node to
	get node pointer
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 18, 2010 at 10:59 AM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Thu, 18 Mar 2010 09:22:39 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> The following structure elements duplicate the information in
>> 'struct device.of_node' and so are being eliminated. =A0This patches
>> makes all readers of the following elements use device.of_node
>> instead.
>
> The NDFC driver also needs a patch... or at least the version from your
> last of_patch set does. I am included the patch I needed to get it to
> compile.

Thanks Sean, I've added this patch to my series.  s-o-b line please?

g.
