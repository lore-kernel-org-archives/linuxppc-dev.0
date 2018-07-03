Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbJN5pkMzF1Pm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:25:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@lists.ozlabs.org
Cc: oss@buserror.net, leoyang.li@nxp.com, bharat.bhushan@nxp.com,
 Diana Craciun <diana.craciun@nxp.com>
Subject: Re: [PATCH v2 1/3] powerpc/fsl: Disable the speculation barrier from
 the command line
In-Reply-To: <1528721608-15443-2-git-send-email-diana.craciun@nxp.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-2-git-send-email-diana.craciun@nxp.com>
Date: Tue, 03 Jul 2018 17:25:55 +1000
Message-ID: <87woucg4qk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Diana Craciun <diana.craciun@nxp.com> writes:

> The speculation barrier can be disabled from the command line
> with the parameter: "nospectre_v1".

Can you please send another patch adding it to Documentation/admin-guide/kernel-parameters.txt

You should mark it as "PPC" only for now.

cheers
