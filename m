Message-ID: <382B46D4.E10355E1@netx4.com>
Date: Thu, 11 Nov 1999 17:44:36 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: reekes@kerbango.com
CC: linuxppc-embedded@lists.linuxppc.org, nick@kerbango.com
Subject: Re: does soft-float work?
References: <382B39C8.EF61D039@kerbango.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Reekes wrote:


> I add the -soft-float option or -mcpu=823.


I didn't know 823 was an option.  I thought all that was
supported was 821 and 860....Doesn't matter, it should simply
be 8xx anyway.



>   gcc -g -lm -msoft-float mathtest.c


Well, now...that -lm looks a little suspicious.  The
libary was probably compiled with hardware floating point
assumed (unless you built your own).

I also remember speaking to someone that found a varargs
and software floating point combination bug.....let me
try and track that down.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
