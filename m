Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C04D6B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 06:02:37 +1000 (EST)
Subject: Re: [PATCH] powerpc/p1010rdb: add EEPROMs to device tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1337783718-25553-1-git-send-email-gustavo@zacarias.com.ar>
Date: Fri, 29 Jun 2012 15:02:36 -0500
Message-Id: <15E0F64B-1D7A-4328-B188-CB24CDA9BD7A@kernel.crashing.org>
References: <1337783718-25553-1-git-send-email-gustavo@zacarias.com.ar>
To: Gustavo Zacarias <gustavo@zacarias.com.ar>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 23, 2012, at 9:35 AM, Gustavo Zacarias wrote:

> Add EEPROM to the P1010RDB device tree.
> The 24c01 acts as a memory SPD so it shouldn't be overwritten without
> care.
> The 24c256 is a general purpose memory.
> 
> Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
> ---
> arch/powerpc/boot/dts/p1010rdb.dtsi |   12 ++++++++++++
> 1 files changed, 12 insertions(+), 0 deletions(-)

applied

- k
