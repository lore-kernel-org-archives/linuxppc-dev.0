Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id DBB39B7CE7
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 06:54:16 +1100 (EST)
Received: by pzk39 with SMTP id 39so37609pzk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:54:15 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAD1004.5050507@freescale.com>
References: <1269632145-28462-1-git-send-email-timur@freescale.com>
	<fa686aa41003261245h52e151ceoa4f85e38055ae6a7@mail.gmail.com>
	<4BAD1004.5050507@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 13:53:55 -0600
Message-ID: <fa686aa41003261253g611eaa6foa06abd79af9a5a10@mail.gmail.com>
Subject: Re: [PATCH] [v2] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wmb@firmworks.com, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 1:50 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>> The node must be a child of a QE node. =A0A QE node can reference the
>> firmware from another QE node by using the fsl,firmware-phandle
>> property.
>
> Ok.
>
> I'll post a V3 once everyone else has a chance to comment.

Also, since it is a documentation only change, I'll pick it up into
the branch that I'm about to ask Linus to merge in the next day or so.

g.
