Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 7BAC467C18
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 10:14:38 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so280703ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Dec 2006 15:14:34 -0800 (PST)
Message-ID: <528646bc0612061514mbcb2627wbe83cd47a06b31b9@mail.gmail.com>
Date: Wed, 6 Dec 2006 16:14:33 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: Re: Virtex device tree generator proof of concept
In-Reply-To: <977C41F842E66D4CB2E41332313B615002F76196@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <977C41F842E66D4CB2E41332313B615002F76196@XSJ-EXCHVS1.xlnx.xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/6/06, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> Hi Grant,
>
> This looks really cool...  I've hacked around in it a bit to generate
> device trees that go more completely through dtc.  (I'd be happy
> to push these modifications back to you, if you're interested...)

Yes please, send me your patches.

>
> I'm curious if you've heard of anyone using device trees other than
> at boot time: for instance, using an incomplete device tree blob to
> represent components discovered at runtime?  It looks like it should
> be possible to rip out alot of the code from kernel/powerpc/prom.c in
> recent kernels to parse incomplete device trees, too...  Any thoughts?

Possible, but there are probably better ways do deal with those; like
just allocating and registering a platform device; or adding nodes to
the existing tree.  If you're able to probe a device, then do you need
to describe it with a device tree fragment?

What scenario are you thinking about?

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
