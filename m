Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8B4746892B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 21:35:04 +1100 (EST)
To: bharathi kandimalla <bharthik2004@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Dec 2005 23:12:31 PST."
	<20051231071231.54555.qmail@web50008.mail.yahoo.com>
Date: Sat, 31 Dec 2005 11:35:01 +0100
Sender: wd@denx.de
Message-Id: <20051231103501.6D9CA354040@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: tftp 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051231071231.54555.qmail@web50008.mail.yahoo.com> you wrote:
>
>      I am working on the MPC860T .I am able to port the linux2.6  on to the board.I got prompt. eventhough I have enabled the tftp   I am not able to get the files  using tftp
>   from the host machine
...
>   [root@(none) ~]# tftp
> -sh: tftp: command not found

"command not found" - this is a pretty clear error message. Try
installing the tftp command on your target system ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
An optimist believes we live in the best world possible; a  pessimist
fears this is true.
