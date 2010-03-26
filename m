Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 6CF29B7BEE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 05:57:00 +1100 (EST)
Received: by pwj8 with SMTP id 8so6640158pwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 11:56:59 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAD018B.6010309@freescale.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
	<fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
	<4BACFF7B.3010002@freescale.com>
	<fa686aa41003261144i61429f23x1217a528fcfb3e66@mail.gmail.com>
	<4BAD018B.6010309@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 12:56:38 -0600
Message-ID: <fa686aa41003261156x701d8929v5e6d410e5d7e06f5@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, Scott Wood <scottwood@freescale.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 12:48 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
>> Nah. =A0That looks totally fine. =A0Not having the firmware under a qe
>> node would look bad to me.
>
> You don't think it weird to have one QE node reference data from another =
QE node, or that the DTS implies that the firmware belongs to one QE more t=
han it belongs to the other?

Nope.

g.
