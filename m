To: cedric_aubert@yahoo.fr
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPCBDM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 May 2003 01:17:07 PDT."
             <20030506081707.57165.qmail@web41813.mail.yahoo.com>
Date: Tue, 06 May 2003 16:06:54 +0200
Message-Id: <20030506140659.BE882C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030506081707.57165.qmail@web41813.mail.yahoo.com> you wrote:
>
> What are the limitations of the MPCBDM ?

- bound to a PC's parallel port (vs. the networked BDI)
- slower downloads
- only support for MPC8xx CPUs
- only few flash types supported
- only mailing list "support"
- no warranty on the hardware

> Is it possible to debug generic C/C++ code without
> linux ?

yes.

> Whatr is the difference with BDI ?

The BDI2000 is a high quality (3 years warranty on the hardware!),
excellently supported (1 year support / software updates included),
professional tool.

The BDM4GDB is a do-it-yourself solution which costs only 2%  of  the
price  of  a  BDI2000. For that price you get a lot of functions, but
it's still weak compared against a BDI2000.

We have both in house (actually selling both of them), but  use  only
BDI2000 for our daily work.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Whenever people agree with me, I always think I must be wrong.
- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
