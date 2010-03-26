Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 4C387B7CF1
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Mar 2010 06:08:05 +1100 (EST)
Received: by pwj8 with SMTP id 8so6651995pwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 12:08:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAD03E2.9020207@firmworks.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003251826m16ea94dfy422fae14fec81204@mail.gmail.com>
	<4BACD011.5050609@freescale.com>
	<fa686aa41003261120o15fea3cev8ca625f389bc8664@mail.gmail.com>
	<4BACFF7B.3010002@freescale.com>
	<fa686aa41003261144i61429f23x1217a528fcfb3e66@mail.gmail.com>
	<4BAD018B.6010309@freescale.com> <4BAD03E2.9020207@firmworks.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Mar 2010 13:07:44 -0600
Message-ID: <fa686aa41003261207x6322f7b7x14c600f9a69fe9bb@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 26, 2010 at 12:58 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> a) Firmware blob in some random place - requires strong naming of either
> firmware blob property or node containing it.

BTW, this exactly the reason for all the bikesheding earlier; but I
don't care at all if it is under a QE node.

g.
