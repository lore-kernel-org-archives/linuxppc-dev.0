To: Eugene Surovegin <ebs@ebshome.net>
Cc: Ron Flory <ron.flory@adtran.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: parse error before `{', stray '\' in program 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Apr 2003 12:04:55 PDT."
             <5.1.0.14.2.20030411115316.0416be20@mail.zultys.com>
Date: Fri, 11 Apr 2003 22:17:48 +0200
Message-Id: <20030411201754.042DBC5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.2.20030411115316.0416be20@mail.zultys.com> you wrote:
>
>          1. Physical source file multibyte characters are mapped,
>             in an implementation-defined manner, to the source character set
>             (introducing new-line characters for end-of-line indicators)
>              if necessary.
>              ....

"\r\n" is not a  multibyte  character  but  a  sequence  of  the  two
characters C and NL.


>          2. Each instance of a backslash character (\) immediately
>             followed by a new-line character is deleted, splicing physical
>             source lines to form logical source lines.
>             ....

This sentence contains the word "immediat" which does not  allow  for
an  additional  CR  character between the backslash character and the
new-line character.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our business is run on trust.  We trust you will pay in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
