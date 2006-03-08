Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id F2035679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 19:38:19 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 9D6AB29ECA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 09:36:40 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12602-02 for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 09:36:38 +0100 (CET)
Received: from archvile (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id B597129EC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 09:36:38 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to quickly write cleanmarkers to jffs2 partitions?
Date: Wed, 8 Mar 2006 09:38:35 +0100
References: <200603021706.14618.david.jander@protonic.nl>
	<200603031008.20075.mathieu.deschamps@com2gether.net>
	<1141647684.23522.7.camel@linpc041.aimsys.nl>
In-Reply-To: <1141647684.23522.7.camel@linpc041.aimsys.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200603080938.35299.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 06 March 2006 13:21, Jaap-Jan Boor wrote:
> On Fri, 2006-03-03 at 10:08 +0100, Mathieu Deschamps wrote:
> > Hi,
> >
> > "When preparing a flash partition for JFFS2, it is recommended to put
> > cleanmarkers to the erased blocks.
> > This might be done my means of "-j" option of the "flash_eraseall" MTD
> > utility. Otherwise, JFFS2 will re-erase the blocks
> > which contain all 0xFF and have no cleanmarker. This is an unneeded
> > wasting of time."
> >
> > Source : http://www.linux-mtd.infradead.org/faq/jffs2.html
> >
> > does this may be relevant ?
>
> This is correct, however flash_eraseall does also (as it's
> name suggests, erase all flash blocks, which takes
> some time on NOR flash. If you 'know' the flash is erased,
> it's not needed.
> I used flash_eraseall to write the cleanmarkers, but without
> erasing blocks (and called that utility cleanmark)

Thanks to all for the suggestions.
Is "cleanmark" an open-source tool? Would you share it?

Greetings,

-- 
David Jander
