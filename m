Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F3EDDDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 09:10:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0TMCU3E028493
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 17:12:30 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0TMAcMQ269088
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 17:10:38 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0TMAbKL032503
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 17:10:38 -0500
Date: Tue, 29 Jan 2008 16:09:24 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: Haleakala Defconfg
Message-ID: <20080129160924.6186b6a1@zod.rchland.ibm.com>
In-Reply-To: <C3C4E335.D193%gerickson@nuovations.com>
References: <C3C4E335.D193%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008 14:05:41 -0800
Grant Erickson <gerickson@nuovations.com> wrote:

> Is there a patch pending to for 'arch/powerpc/configs/haleakala_defconfig'?

Not to my knowledge.

> I did not see one in either of:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
>     git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> If no patch is pending, to whom do I submit such a patch? It'll simply be a
> near clone of 'kilauea_defconfig', save the "CONFIG_DEVICE_TREE" entry.

Send one to me.  CC Stefan Roese please.

josh
