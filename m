To: cedric_aubert@yahoo.fr
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: (Sudo off topic)Simple cheap IDE intrerface for IBM 405 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 25 Jun 2003 00:06:37 PDT."
             <20030625070637.16435.qmail@web41812.mail.yahoo.com>
Date: Wed, 25 Jun 2003 18:03:08 +0200
Message-Id: <20030625160313.29C3BC5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030625070637.16435.qmail@web41812.mail.yahoo.com> you wrote:
>
> For information, what is the cheap simple IDE interface for the MPC8xx
> that you talk about ?

Using the internal PCMCIA controller. All you need is bus drivers and
a trivial (2 gates) address decoder.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
On the subject of C program indentation: "In My Egotistical  Opinion,
most  people's  C  programs  should be indented six feet downward and
covered with dirt."                               - Blair P. Houghton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
