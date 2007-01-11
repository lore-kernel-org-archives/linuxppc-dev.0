Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2A12CDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 12:15:33 +1100 (EST)
To: "Daniel Martineschen" <martineschen@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5200 + boa webserver + CGI + broken pipe 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2007 09:07:29 -0200."
	<3acfce80701100307o18a24b37q616bb0c8ec4086dd@mail.gmail.com>
Date: Thu, 11 Jan 2007 02:15:30 +0100
Sender: wd@denx.de
Message-Id: <20070111011530.8091635264F@atlas.denx.de>
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

In message <3acfce80701100307o18a24b37q616bb0c8ec4086dd@mail.gmail.com> you wrote:
>
> > This is most probably a hardware issue (bad SDRAM initialization?)
> 
> yes, but why does it happen only when we use the boa webserver? when

Probably because this causes a specific load pattern  which  triggers
the problem.

> My point is: is it really a bad choice to use boa? can boa really be
> causing so much trouble?

No, probably any other application might have caused the same effect.

Is this a Rev. B CPU? Are you using current code? For example, do you
perform the required SDelay initialization (AN3221) ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
So we follow our wandering paths, and the very darkness acts  as  our
guide and our doubts serve to reassure us. - Jean-Pierre de Caussade,
eighteenth-century Jesuit priest
