Return-Path: <hollis@penguinppc.org>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id 8BB756838D
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Oct 2005 12:22:21 +1000 (EST)
In-Reply-To: <20051003021129.20564.qmail@kunk.qbjnet.com>
References: <20051003021129.20564.qmail@kunk.qbjnet.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4641d8304aa3e61826054e240b821540@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Sun, 2 Oct 2005 21:22:13 -0500
To: Bob Brose <linuxppcdev@qbjnet.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Q: signed vs unsigned char,
	PPC vs x86 gcc 3.3.5 compiler differences
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 2, 2005, at 9:11 PM, Bob Brose wrote:

> If I change the declaration of atest to a signed char on PPC I get the
> same result as x86.
>
> Does this mean the char in x86 is signed and in PPC it's unsigned?
> Has it always been thus?

Yes, and yes. If it matters to you, you should explicitly use "signed 
char" or "unsigned char"...

-Hollis
