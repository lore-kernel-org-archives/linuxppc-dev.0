To: "svacca@valcom.com" <svacca@valcom.com>
Cc: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Execute Reset via CheckStop approach 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Jul 2002 09:45:37 EDT."
             <01C2322D.B3A24AF0.svacca@valcom.com>
Date: Tue, 23 Jul 2002 15:54:20 +0200
Message-Id: <20020723135425.6DEF310875@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <01C2322D.B3A24AF0.svacca@valcom.com> you wrote:
>
> I would like to execute an Internal Hard Reset on an MPC860T
> bd. using the Checkstop Reset approach.

THis is what we do on all 8xx and 8260 systems.

> Does anyone have some code that I could utilize to implement
> this?

Sure. Check out our 2.4.4 kernel tree; see
http://www.denx.de/solutions-en.html#CVS-Linux

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Nothing ever becomes real till it is experienced -- even a proverb is
no proverb to you till your life has illustrated it.     - John Keats

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
