To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems rebuilding the DENX ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Jul 2003 09:14:00 +0200."
             <3F1F8738.3040209@imc-berlin.de>
Date: Thu, 24 Jul 2003 09:58:33 +0200
Message-Id: <20030724075838.5964DC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

in message <3F1F8738.3040209@imc-berlin.de> you wrote:
>
> I am trying to rebuild the great DENX's ELDK from scratch.
> My host is a SuSE 8.2 system.
> The first obstacle is that some packages won't build with recent
> automake/autoconf version. So I got some old versions built and
> installed them on my system.
>
> Now the first step - build the RPM - works. I do get a rpm binary in
> /opt/eldk/build/ppc-2003-07-23/work/bin

Just a note: if this is not really urgent, you  might  just  want  to
wait a bit. We're working on the next release of the ELDK, which will
be based on YD-3.0, which contains rpm-4.1

I guess we will have to validate this release  with  a  SuSE  system,
too.



Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anyone can count the seeds in an apple.
No one can count the apples in a seed.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
