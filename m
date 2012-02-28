Return-Path: <glikely@secretlab.ca>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00AC8B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 15:39:05 +1100 (EST)
Received: by obbta2 with SMTP id ta2so2533669obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 20:39:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20120228130634.3c511b096bc78f9b99e804fe@canb.auug.org.au>
References: <20120228130634.3c511b096bc78f9b99e804fe@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 27 Feb 2012 21:38:43 -0700
Message-ID: <CACxGe6sLLxUL4U3fP6dOSOu+tYaMZkG6z7RWHqp-CX06Ztp1CQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the devicetree tree with the powerpc
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 27, 2012 at 7:06 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Grant,
>
> Today's linux-next merge of the devicetree tree got a conflict in
> arch/powerpc/platforms/iseries/Kconfig between commit 3d066d77cf46
> ("powerpc: remove CONFIG_PPC_ISERIES from the architecture Kconfig
> files") from the powerpc tree and commit 0f22dd395fc4 ("of: Only compile
> OF_DYNAMIC on PowerPC pseries and iseries") from the devicetree tree.
>
> The former commit removes the file (as the legacy iSeries platform is
> being removed), so I did that.

Okay, thanks.

g.

> --
> Cheers,
> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.org=
.au



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
