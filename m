Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F371267B26
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 09:26:30 +1100 (EST)
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Cannot compile denx 2.6.15 for MBX 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Mar 2006 21:36:26 +0100."
	<200603062136.26121.antonio.dibacco@aruba.it>
Date: Mon, 06 Mar 2006 23:26:27 +0100
Sender: wd@denx.de
Message-Id: <20060306222627.CB6BC3535F7@atlas.denx.de>
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

In message <200603062136.26121.antonio.dibacco@aruba.it> you wrote:
> I do:
> 
> >make mrproper
> >make MBX_config
> 
> HOSTCC  scripts/basic/fixdep
> HOSTCC  scripts/basic/split-include
> HOSTCC  scripts/basic/docproc
> make[1]: *** No rule to make target `MBX_config'.  Stop.
> make: *** [MBX_config] Error 2
> 
> What's the problem?

You ask for a non-supported board. The MBX board is not supported  in
the  public  2.6 kernel tree, and we did not add it either (and don't
intend to, as this board is, umm, *very* old).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
But the only way of discovering the limits  of  the  possible  is  to
venture a little way past them into the impossible.
                         - _Profiles of the Future_ (1962; rev. 1973)
                  ``Hazards of Prophecy: The Failure of Imagination''
