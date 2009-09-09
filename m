Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 00B63B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 06:28:13 +1000 (EST)
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090909182227.GA8215@b07421-ec1.am.freescale.net>
Date: Wed, 9 Sep 2009 15:28:01 -0500
Message-Id: <F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Roland Lezuo <roland.lezuo@chello.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 9, 2009, at 1:22 PM, Scott Wood wrote:

> On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
>> The following patch is needed to correctly assign the IRQs for the
>> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
>> as well as the interrupt lines for the two devices.
>
> And it will incorrectly assign them on older revisions of the chip.
>
> We really should have a u-boot fixup based on SVR.

I felt like Kim did this.

- k
