To: gopi@tejasnetworks.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Accessing file from drivers 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 15 Mar 2001 18:26:43 +0530."
             <Pine.LNX.4.21.0103151822090.9108-100000@localhost.localdomain>
Date: Thu, 15 Mar 2001 15:04:31 +0100
Message-Id: <20010315140436.113DA281DB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.21.0103151822090.9108-100000@localhost.localdomain> you wrote:
>
>   Is it possible to read and write to files (say /etc/xyz)
> in a device driver without resorting to user space?  I want

You do not want to do this. It's bad design. Implement an ioctl() for
the configuration, and use that.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Send lawyers, guns and money..."  - Lyrics from a Warren Zevon song

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
