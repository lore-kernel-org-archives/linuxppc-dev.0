Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5621A67DDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 08:41:57 +1100 (EST)
To: Stephen Yee <stonepine@126.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FYI: SM5xx toolchain project berliOS registration 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 21 Nov 2006 02:54:42 +0800."
	<4561F9F2.8020706@126.com>
Date: Mon, 20 Nov 2006 22:41:55 +0100
Sender: wd@denx.de
Message-Id: <20061120214155.91777352643@atlas.denx.de>
Cc: Stephen Yee <shyi@bmrtech.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4561F9F2.8020706@126.com> you wrote:
>
> is Here a  successful  story  about using SM501 on PPC platform with
> this driver?  and would you please give me some advices to drive this
> devices?

Not in the context of the 2.6 kernel. But we have a working
configuration of MPC5200 + SM501 in our 2.4 kernel tree; see the
"TQM5200" board config at
http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If a group of N persons implements a COBOL compiler,  there  will  be
N-1 passes. Someone in the group has to be the manager. - T. Cheatham
