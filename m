To: Tim Lai <laitingwai@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can I run linux without a file system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Jun 2002 08:08:53 PDT."
             <20020621150853.2021.qmail@web21104.mail.yahoo.com>
Date: Fri, 21 Jun 2002 21:54:49 +0200
Message-Id: <20020621195454.7623D1030A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020621150853.2021.qmail@web21104.mail.yahoo.com> you wrote:
>
> Does that means I have to have some sort of file
> system in linux?

Yes. Things like root directory, working directory, device files, ...
are essential concepts of Unix; you  cannot  get  rid  of  them  that
easily - nor is there any reason to do so.

One day you will probably want to run some application -  where  will
you put it?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Language shapes the way we think, and determines what we  can  think
about."                                                 - B. L. Whorf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
