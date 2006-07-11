Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C6EBF67B5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 09:38:31 +1000 (EST)
To: "chao yu" <cchaoyu@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: "Bad trap at PC: 3000xxxx, SR: xxxx, vector=xxx Not tainted" 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Jul 2006 07:18:53 +0800."
	<56c993430607111618q2cd0cfach4abb4d15ea25d05@mail.gmail.com>
Date: Wed, 12 Jul 2006 01:38:26 +0200
Sender: wd@denx.de
Message-Id: <20060711233826.BC17F352681@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <56c993430607111618q2cd0cfach4abb4d15ea25d05@mail.gmail.com> you wrote:
> 
> I port the linux 2.4 kernel to our mpc8541 board, but when it executes the
> run_init_process("/sbin/init") in the init function, it will disaplay "Bad
> trap at PC: 3000xxxx, SR: xxxx, vector=xxx    Not tainted" continually. The
> ramdisk is from ELDK 4.0 package for 85xx which is pre-built. Who can tell
> me what was happened?

Well, for one thing ELDK 4.0 is based on a 2.6 kernel...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Nothing ever becomes real till it is experienced -- even a proverb is
no proverb to you till your life has illustrated it.     - John Keats
