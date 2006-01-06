Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9DC3E689C9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 02:08:57 +1100 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Jan 2006 15:19:13 +0100."
	<200601061519.14550.david.jander@protonic.nl>
Date: Fri, 06 Jan 2006 16:08:54 +0100
Sender: wd@denx.de
Message-Id: <20060106150854.918FF353A43@atlas.denx.de>
Cc: HappyPhot <happyphot@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: VFS: Cannot open root device "31:03" or unknown-block(31,3) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200601061519.14550.david.jander@protonic.nl> you wrote:
>
> > > I see you are using DENX ELDK 3.1.1 and a kernel which AFAIK is not
> > > supported

This is a serious misunderstanding. There is no  such  thing  like  a
specific kernel version which is supported by the ELDK.

You don't talk about any specific version of a  C  programm  that  is
supported by the GNU compiler either.


The ELDK is primarily a *toolkit* which works with  arbitrary  C  and
C++  programs  and  with  any version of the kernel tree (at least in
theory; very recent version s of the Linux kernel [ > 2.6.14]  cannot
be compiled with ELDK 3.1.x any more, but this is a different issue).

> >   Do you know where to get the infomation about which kernel version it
> > supports?

The ELDK supports *any* kernel version.

> The one that comes with that version of ELDK? Just a guess ;-)

Wrong guess.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"I've seen it. It's rubbish."          - Marvin the Paranoid Android
