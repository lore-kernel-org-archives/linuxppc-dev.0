Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 7665E68002
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 23:48:13 +1000 (EST)
To: Sylvain Munaut <tnt@246tNt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Aug 2005 15:31:59 +0200."
	<4309D3CF.4030201@246tNt.com>
Date: Mon, 22 Aug 2005 15:48:01 +0200
Sender: wd@denx.de
Message-Id: <20050822134801.9D932353D18@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] MPC5200 BestComm microcode [en]/[de]coding draft 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4309D3CF.4030201@246tNt.com> you wrote:
> 
> But I'm not sure including that into the Documentation/ directory is
> such a good idea. Changing documentation that's there requires sending
> patch to Linus and get it processed etc ... And since It's mostly
> reverse engineering, it's probably going to change often as we get a
> better understanding.

Documentation/  is  the  first  place  to  look  for   Linux   kernel
documentation, so it seems the best place for such stuff to me.

> We could publish it as a Wiki (that's a tendency these days ;) so that
> everyone can contribute easily and post code examples etc ... What do
> you think ?

This is a good idea for collecting  the  information,  but  IMHO  the
document itself should go (too) to Documentation/

Just my $ 0.02

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Programmer's Lament: (Shakespeare, Macbeth, Act I, Scene vii)
        "That we but teach bloody instructions,
        which, being taught, return to plague the inventor..."
