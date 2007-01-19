Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 1190BDDE25
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 03:38:38 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so480667ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 08:38:36 -0800 (PST)
Message-ID: <528646bc0701190838w106d6407h9516ccc37349111a@mail.gmail.com>
Date: Fri, 19 Jan 2007 09:38:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Subject: Re: Discussion on SOC device tree bindings
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3023612F8@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <CB20EEEE-9C3D-4FFC-869E-D331F8CA264A@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3023612F8@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/19/07, Yoder Stuart-B08248 <stuart.yoder@freescale.com> wrote:
>
> Back in Grant's original summary of the problem he wrote:
> >
> > 5. The contentious issue is which direction those links should be
> > constructed.  Does the device node describe where to find it's SoC
> > parent node and what the device index is?  Or does the SoC node
> > describe which device nodes it provides shared register service for?
>
> How about linking in _both_ directions?

I think that's a bad precedence.  Either representation can be
generated from the other.  Linking it in both directions means
duplicate information with no real benefit.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
