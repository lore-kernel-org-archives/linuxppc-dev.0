Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5994FDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 04:36:35 +1000 (EST)
Message-Id: <D537A149-0BBB-4802-BE8B-61A1F2DB78D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090427162428.8133.23523.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/86xx: Add device_type entry to soc for ppc9a
Date: Mon, 27 Apr 2009 13:02:11 -0500
References: <20090427162428.8133.23523.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 11:24 AM, Martyn Welch wrote:

> The 'device_type = "soc";' line *is* needed in the DTS for  
> get_immrbase()
> to return the correct address.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> arch/powerpc/boot/dts/gef_ppc9a.dts |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied to merge

- k
