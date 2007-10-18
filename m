Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6621DDF42
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 01:01:07 +1000 (EST)
In-Reply-To: <1192720186-25228-1-git-send-email-leoli@freescale.com>
References: <1192720186-25228-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1717431-3C1F-4528-9949-32C156F5DD4F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 resend 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 10:01:42 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 10:09 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Fix a typo in previous one.
>
>  arch/powerpc/boot/dts/mpc8377_mds.dts |  282 ++++++++++++++++++++++ 
> +++++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts |  264 ++++++++++++++++++++++ 
> +++++++
>  arch/powerpc/boot/dts/mpc8379_mds.dts |  300 ++++++++++++++++++++++ 
> +++++++++++
>  3 files changed, 846 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts

still has issues with the i2c nodes.  (maybe v7 will be lucky)

- k
