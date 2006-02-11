Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E5F9867B2A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 03:08:28 +1100 (EST)
To: Sylvain Munaut <tnt@246tNt.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Stability of MPC5200 FEC 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 11 Feb 2006 16:28:26 +0100."
	<43EE029A.5040504@246tNt.com>
Date: Sat, 11 Feb 2006 17:08:25 +0100
Sender: wd@denx.de
Message-Id: <20060211160825.DBDCA35262C@atlas.denx.de>
Cc: Asier Llano Palacios <a.llano@ziv.es>, John Rigby <jrigby@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <43EE029A.5040504@246tNt.com> you wrote:
>
> > had before the Platform Device rework. But the problem is that we are
> > experiencing that the FEC stops working after a long uptime.
> 
> Did you ever observe that behavior on a lite5200 ?
> What is 'long uptime' and do you have sustained transfer during that
> period ? (To try reproduice the problem).

This is a well-known problem,  I'm  afraid.  To  trigger  it,  it  is
usually  (*)  sufficient to transfer a large file (700 MB or so) over
FTP to the target. Note that I've  encountered  the  problem  in  the
context of the 2.4 kernel.

(*) In some cases you can run several such transfers in a row without
problem. Power-cycling the board will bring it back to "normal" mode.

It's probably Bestcomm related. See  the  previous  discussions  with
Freescale about known issues with the 2.6 Bestcomm code.

> Also, what are the 'symptoms' ? (anything in dmesg ?)

No, nothing.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Like winter snow on summer lawn, time past is time gone.
