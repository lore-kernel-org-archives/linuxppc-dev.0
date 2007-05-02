Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB3ADDDF2F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:19:14 +1000 (EST)
Date: Wed, 2 May 2007 09:19:01 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches for 2.6.22
Message-Id: <20070502091901.4c37ecbb.kim.phillips@freescale.com>
In-Reply-To: <42664CF1-75AF-4343-BC50-870D3614C683@kernel.crashing.org>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<20070430145119.6713490e.kim.phillips@freescale.com>
	<42664CF1-75AF-4343-BC50-870D3614C683@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, jeff@garzik.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2 May 2007 09:12:36 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> I'll pull patches 1, 3, 4 and wait on the dts changes until you sort  
> of the ucc driver issues with Jeff.

sounds good.  I was waiting for the get_property -> of_get_propery
patches for ucc_geth before I submitted the follow-on patch to change
interface-type and remove max-speed.  It's out now, so I can proceed.

Kim
