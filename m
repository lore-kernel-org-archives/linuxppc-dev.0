Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 7975367F67
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 06:44:29 +1000 (EST)
To: surendra.yadav@softdel.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Aug 2005 19:04:54 +0530."
	<BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com>
Date: Tue, 16 Aug 2005 21:42:22 +0200
Sender: wd@denx.de
Message-Id: <20050816194222.17757353AB5@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Framebuffer driver using SM501 hardware. 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com> you wrote:
> 
> I am writing framebuffer driver using SM501. This graphics driver chip can

Why are you re-inventing the wheel?

> drive CRT and TFT panel. I have written two seperate framebuffer driver, one
> for CRT and one for TFT Panel.

Why didn't you use the existing framebuffer driver?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If a group of N persons implements a COBOL compiler,  there  will  be
N-1 passes. Someone in the group has to be the manager. - T. Cheatham
