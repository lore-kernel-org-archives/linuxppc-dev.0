From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Jan Nieuwenhuizen <janneke@gnu.org>, khendricks@ivey.uwo.ca
Subject: Re: Please Help!, Need to test glibc 2.1.3 with these additional patches under 2.3 kernels
Date: Wed, 16 Feb 2000 11:32:22 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <200002161626.RAA20871@appel.flower>
In-Reply-To: <200002161626.RAA20871@appel.flower>
MIME-Version: 1.0
Message-Id: <00021611543900.01588@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Will do.
>
> Please send us the cvs command.

Thanks!

First, login to cvs server
enter "anoncvs" as the password:

   cvs -z4 -d :pserver:anoncvs@anoncvs.cygnus.com:/cvs/glibc login


Then to check out the 2.1 branch of the source tree:

   cvs -z4 -d :pserver:anoncvs@anoncvs.cygnus.com:/cvs/glibc co \
   -r glibc-2-1-branch libc


Or, if it is easier, I have put a tar gzip archive of yesterday's CVS tree on
my ftp server:

ftp://khendricks.ivey.uwo.ca/pub/

 --
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
