Return-Path: <lagrange@fr.oleane.com>
Received: from smtp7.clb.oleane.net (smtp7.clb.oleane.net [213.56.31.27])
	by ozlabs.org (Postfix) with ESMTP id E927E679FC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Feb 2006 20:57:50 +1100 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Andy Fleming'" <afleming@freescale.com>
Subject: RE: Gianfar is slower  than fcc_enet on MPC8541 ???
Date: Mon, 27 Feb 2006 11:03:20 +0100
Message-ID: <002601c63b85$0b2e9850$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <9A05AF34-3A14-4D64-9EDF-81D7C3C315FE@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Andy,

> The answer there is simple: stupidity!
The word is too hard, just say forgetting  :-)

Thanks again
Laurent

> -----Message d'origine-----
> De : Andy Fleming [mailto:afleming@freescale.com]
> Envoye : jeu. 23 fevrier 2006 21:08
> A : Laurent Lagrange
> Cc : linuxppc-embedded@ozlabs.org; vbordug@ru.mvista.com;
> pantelis.antoniou@gmail.com
> Objet : Re: Gianfar is slower than fcc_enet on MPC8541 ???
> 
> 
> 
> On Feb 23, 2006, at 11:28, Laurent Lagrange wrote:
> 
> > Hi everybody,
> >
> > I tried the below Andy's idea. It works fine.
> > It is my TCP clients which now slow the traffic.
> >
> > But I don't know why the default timeouts are so high.
> > If the traffic is high, the timeout does not fire.
> > If the traffic is low, the timeout seems too long (???).
> 
> The answer there is simple: stupidity!  :)  I just didn't carefully  
> test the values for performance when I chose them.  I probably also  
> did the math wrong, because I was more concerned about seeing if it  
> worked at all.  It's also possible it got set that way to see a  
> measurable difference to prove it was working, and then got left as  
> the default.  Rest assured, there was not a deliberate reason.  We  
> submitted a patch once this performance issue was discovered.
> 
> 
> 
> 
> 
