Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9D45DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 10:00:58 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0TN0tIY018450
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 18:00:55 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0TN0tGw278446
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 18:00:55 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0TN0sSa032360
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Jan 2008 18:00:55 -0500
Date: Tue, 29 Jan 2008 16:59:41 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH] 4xx: Clone haleakala_defconfig from kilauea_defconfig
Message-ID: <20080129165941.1681842f@zod.rchland.ibm.com>
In-Reply-To: <C3C4ED97.D197%gerickson@nuovations.com>
References: <20080129160924.6186b6a1@zod.rchland.ibm.com>
	<C3C4ED97.D197%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Roese <sr@denx.de>, Stefan,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008 14:49:59 -0800
Grant Erickson <gerickson@nuovations.com> wrote:

> On 1/29/08 2:09 PM, Josh Boyer wrote:
> > On Tue, 29 Jan 2008 14:05:41 -0800
> > Grant Erickson <gerickson@nuovations.com> wrote:
> > 
> >> Is there a patch pending to for 'arch/powerpc/configs/haleakala_defconfig'?
> > 
> > Not to my knowledge.
> > 
> >> I did not see one in either of:
> >> 
> >>     git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git
> >>     git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> >> 
> >> If no patch is pending, to whom do I submit such a patch? It'll simply be a
> >> near clone of 'kilauea_defconfig', save the "CONFIG_DEVICE_TREE" entry.
> > 
> > Send one to me.  CC Stefan Roese please.
> > 
> > josh
> 
> * Allow for 'make haleakala_defconfig' by providing a default configuration
>   for the AMCC PowerPC 405EXr "Haleakala" board.
> 

As silly as it sounds, I need a Signed-off-by for this.  Could you read
Documentation/SubmittingPatches section 12 and just reply to this with
a Signed-off-by line?

josh
