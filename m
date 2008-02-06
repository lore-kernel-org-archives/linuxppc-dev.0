Return-Path: <glikely@secretlab.ca>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.245])
	by ozlabs.org (Postfix) with ESMTP id 7D2EEDDDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 05:21:03 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so3107214hsb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 10:21:01 -0800 (PST)
Message-ID: <fa686aa40802061021x39a5dab3qd9a676b813b738b@mail.gmail.com>
Date: Wed, 6 Feb 2008 11:21:00 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Geoff Levand" <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH v3] [POWERPC] bootwrapper: build multiple cuImages
In-Reply-To: <47A9F734.9050005@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
	<47A9F734.9050005@am.sony.com>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> Grant Likely wrote:
> > diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-mpc7448hpc2.c
> > similarity index 100%
> > rename from arch/powerpc/boot/cuboot-hpc2.c
> > rename to arch/powerpc/boot/cuboot-mpc7448hpc2.c
>
>
> This is not a proper patch.
>
> No rule to make target `arch/powerpc/boot/cuboot-mpc7448hpc2.c

I've dropped the -M flag from git-format-patch for v4 of the patch.
You should have it any moment now.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
