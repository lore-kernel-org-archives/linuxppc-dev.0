Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8F6C0DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 18:50:50 +1100 (EST)
To: Nethra <nethra_gmit@yahoo.co.in>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: jffs2-No space left on device 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 Mar 2007 23:41:33 MST."
	<9469217.post@talk.nabble.com>
Date: Wed, 14 Mar 2007 08:50:47 +0100
Sender: wd@denx.de
Message-Id: <20070314075047.78939352676@atlas.denx.de>
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

In message <9469217.post@talk.nabble.com> you wrote:
> 
> Through nfs mounting of root file system.I m trying jffs2 mounting without
> any image( with empty patition).. it is giving 100% of space is used.I m
> getting same output with jffs2 image also.
> what is the actual problem?

The actual problem is that your don't read error messages.

> Erase at 0x002a0000 failed immediately: -EROFS. Is the sector locked?
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your file system / partition is read-only, probably because the flash
sectors are locked.

Try unlocking the flash partition before using it.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
After a heated argument on some trivial matter Nancy [Astor]  .  .  .
shouted,  ``If  I were your wife I would put poison in your coffee!''
Whereupon Winston Churchill with equal heat and  sincerity  answered,
``And if I were your husband I would drink it.''
