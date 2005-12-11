Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3231A6888C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Dec 2005 08:47:40 +1100 (EST)
To: "Absolut Hunter" <absoluthunter@comcast.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Dec 2005 11:16:57 PST."
	<003101c5fcf5$1ff05b80$6405a8c0@absolut>
Date: Sun, 11 Dec 2005 22:47:38 +0100
Sender: wd@denx.de
Message-Id: <20051211214738.0E4ED353A44@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 82xx-HCI-USB & Webcams / PWC 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

in message <003101c5fcf5$1ff05b80$6405a8c0@absolut> you wrote:
> 
> Has anyone attempted to use the Phillips web cam driver, pwc.o, that is
> built into the standard 2.4.25 DENX kernel? I think its version 8.x
> something.

The current code uses version 10.0.7a of the driver. This driver  has
been  tested  on  several  MPC5200  based systems (plain old IceCube,
TQM5200, and custom hardware). It works fine there.

> Anyone tried this?

We did, and it works fine. [Make sure to use current code, i. e. commit
e09474c3e0963b58470b447ab25188499e5c4af1 or later; see
http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=commit;h=e09474c3e0963b58470b447ab25188499e5c4af1

See also  Documentation/README.webcam inthe source tree.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Genius doesn't work on an assembly line basis.  You can't simply say,
"Today I will be brilliant."
	-- Kirk, "The Ultimate Computer", stardate 4731.3
