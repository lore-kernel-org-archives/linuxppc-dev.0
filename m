Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 9AB0967C39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 04:40:00 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Jul 2005 10:21:51 +0200."
	<200507191021.52063.david.jander@protonic.nl>
Date: Tue, 19 Jul 2005 20:37:45 +0200
Sender: wd@denx.de
Message-Id: <20050719183745.AD52A352671@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How reliable is jffs2 really (denx cvs devel kernel)? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200507191021.52063.david.jander@protonic.nl> you wrote:
> 
> I have seen some strange problems with jffs2. I have been victim of the BUG() 
> in fs/jffs2/gc.c, line 139. I have been battling with kgdb to see what 
> happens there. Here are my findings until now (I am still working on this):

You probably want to ask this on the MTD mailing list;  don't  forget
to  mention  the  exact  version of the MTD / JFFS2 code you're using
(see CVS history).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Success in marriage is not so much finding the right person as it  is
being the right person.
