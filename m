Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2BA8A67C31
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 15:39:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7O6vuXH006508
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:57:56 -0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7O5d6vd000411
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:39:07 -0500 (CDT)
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156396647.8433.184.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
	<1156304163.8433.19.camel@localhost.localdomain>
	<44EC15A1.4090807@freescale.com>
	<1156369941.8433.57.camel@localhost.localdomain>
	<1156394597.5310.42.camel@localhost.localdomain>
	<1156396647.8433.184.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156397928.5913.38.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Aug 2006 13:38:48 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 13:17, Benjamin Herrenschmidt wrote:
> > Evolution 1.2.2. I had found the reason and tested on my side.
> > Paul, if you do not modify it by hand, please select the following
> :-).
> > I will repost the mpic and mpc7448hph2 irq update patch.Very sorry
> for that.
> 
> Ok, the trick with evolution is to use the "preformat" style.
> 
> Typically, when posting a patch, I write my description, put the caret
> where I want to insert the patch itself, set the style to
> "Preformat" (from the pop-up menu just above the text editing zone),
> and
> do Insert->Text File from the menu.
> 
> You can also select a bit of text/patch and change the style to
> "Preformat" afterward if you missed it before doing the import.
> 
You words are  principle to post patch with evolution :-).
Roy
