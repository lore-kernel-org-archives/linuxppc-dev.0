Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D2B8CDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 09:04:36 +1000 (EST)
To: "Charles Krinke" <ckrinke@istor.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPC login puzzle 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Mar 2007 20:51:02 PDT."
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
Date: Sun, 01 Apr 2007 01:04:33 +0200
Sender: wd@denx.de
Message-Id: <20070331230433.9241335261B@atlas.denx.de>
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

In message <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com> you wrote:
>
> The question is:
>  
> "What are the various things that might cause one toaster to be able to login from a telnet session and another, very similar one to not be able to do this?"

Different settings of "disable = ..." in the /etc/xinetd.d/telnet
config file?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It is easier to port a shell than a shell script."      - Larry Wall
