Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id C258ADE0D1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:57:52 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so4358623agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:57:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ba5d9360903101555o3d6f5932k9292a006328c7161@mail.gmail.com>
References: <ba5d9360903101553h3cf7c33ex639999803655c440@mail.gmail.com>
	<ba5d9360903101555o3d6f5932k9292a006328c7161@mail.gmail.com>
Date: Tue, 10 Mar 2009 17:57:51 -0600
Message-ID: <fa686aa40903101657w1232097flb3535f911ef81c1e@mail.gmail.com>
Subject: Re: TSEC/MDIO bug in recent kernels
From: Grant Likely <grant.likely@secretlab.ca>
To: Johns Daniel <johns.daniel@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 4:55 PM, Johns Daniel <johns.daniel@gmail.com> wrot=
e:
> For those of you who are running into this error:
> =A0 =A0 =A0 =A024520:01 not found
> =A0 =A0 =A0 =A0eth0: Could not attach to PHY
> =A0 =A0 =A0 =A0IP-Config: Failed to open eth0
> =A0 =A0 =A0 =A0IP-Config: Device `eth0' not found.
>
> There is a bug in recent kernels. I found it in 2.6.28.7:
> =A0 =A0 =A0 =A0linux/arch/powerpc/sysdev/fsl_soc.c:
> for_each_compatible_node(np, "mdio", "gianfar");
> should be:
> =A0 =A0 =A0 =A0linux/arch/powerpc/sysdev/fsl_soc.c:
> for_each_compatible_node(np, "mdio", "gianfar")

This code is gone in what will become 2.6.29, but the fix can be
backported into the stable tree.  Do you want to generate and send the
patch (and get your name in the commit message)?  Send the patch to
afleming@freescale.com, linuxppc-dev@ozlabs.org and to
stable@kernel.org.  Make sure you specify that this is applicable for
2.6.28 only.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
