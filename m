Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 74F76688EE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 10:21:05 +1100 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Dec 2005 19:05:14 +0300."
	<439859BA.6060600@ru.mvista.com>
Date: Fri, 09 Dec 2005 00:21:03 +0100
Sender: wd@denx.de
Message-Id: <20051208232103.756E4353F77@atlas.denx.de>
Cc: jimmy liu <jimmyzhmliu@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Need help for Linux hangs 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Vitaly,

in message <439859BA.6060600@ru.mvista.com> you wrote:
> jimmy liu wrote:
> > I have U-Boot running on a board similar to
> > MPC8260ADS.
> > bootargs=root=/dev/ram rw console=ttyS0,115200
> try to set console=ttyCPM0,115200 in the bootargs.
                     ^^^^^^^
> > When I run command: bootm ff060000 ff260000, the
> > prompt shows message:
> > ## Booting image at ff060000 ...
> >    Image Name:   Linux-2.4.25
                           ^^^^^^

That's bad advice.

The 2.4.25 kernel will definitely NOT work with console=ttyCPM0

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Immortality consists largely of boredom.
	-- Zefrem Cochrane, "Metamorphosis", stardate 3219.8
