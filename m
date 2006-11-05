Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 303E567CB2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 02:48:23 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 05 Nov 2006 11:21:37 +0100."
	<20061105102137.GG79990@server.idefix.loc>
Date: Sun, 05 Nov 2006 16:48:19 +0100
Sender: wd@denx.de
Message-Id: <20061105154819.9DE59353A5F@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061105102137.GG79990@server.idefix.loc> you wrote:
> 
> > Then just check out the 2.6.18 version of the tree.  This  is  a  git
> > repo, so seeking to any version you like is a matter of seconds.
> 
> hm, I did it but was not successfully. What I did was:
...
> git checkout -b private2.6.18 v2.6.18

This will give you the  exact  2.6.18  kernel.org  tree  without  any
extensions  / modifications. It has even less support for the MPC5200
than our tree, wher eit is unsupported.

> Now I had kernel 2.6.18 but without network :(

ACK. The kernel.org tree does not include Sylvain's patches.

> ok, that is clear but if the kernel boots fine on the board with
> network and I am able to patch it with Xenomai I can live with it.

You mean, you don't care about reliability?  Umm...  then  you  don't
need Xenomai, either.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"In matrimony, to hesitate is sometimes to be saved."        - Butler
