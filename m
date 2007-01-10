Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2E859DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 11:54:09 +1100 (EST)
To: "Daniel Martineschen" <martineschen@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5200 + boa webserver + CGI + broken pipe 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Jan 2007 16:01:26 -0200."
	<3acfce80701091001u27cac269q2fa227daf543a7d4@mail.gmail.com>
Date: Wed, 10 Jan 2007 01:54:07 +0100
Sender: wd@denx.de
Message-Id: <20070110005407.46FF635264F@atlas.denx.de>
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

In message <3acfce80701091001u27cac269q2fa227daf543a7d4@mail.gmail.com> you wrote:
>
> Additionally, the system breaks (but it doesn't happen all the time)
> and reports following message (repeated 3 or 4 times before total
> freeze):
> 
> Machine check in kernel mode.

This is most probably a hardware issue (bad SDRAM initialization?)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Children begin by loving their parents. After a time they judge them.
Rarely, if ever, do they forgive them.                  - Oscar Wilde
