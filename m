Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D22@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: "'karim@opersys.com'" <karim@opersys.com>, brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: x86(host) --> ppc(tgt) cross-tool-chain
Date: Fri, 6 Jun 2003 11:00:47 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I built the toolchain on x86 host for PPC, and I used

GCC-2.95.3
GLIBC-2.2.3
Binutils-2.11.92

I did not use Karim's book. I went with "Embedded Linux Interfacing ...."
book.

Lokesh

-----Original Message-----
From: Karim Yaghmour [mailto:karim@opersys.com]
Sent: Friday, June 06, 2003 10:33 AM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: x86(host) --> ppc(tgt) cross-tool-chain



BTW, there's an ongoing thread about exactly this problem
on the embeddedTUX.org mailing list:
http://www.embeddedtux.org/pipermail/etux/2003-June/thread.html

Apparently you're not alone ...

Karim

brian.auld@adic.com wrote:
>
> Hello,
>
> Using Karim's new book "Building Embedded Linux Systems", has anyone out
there successfully built an x86(host) --> ppc(tgt) tool chain using the
versions stipulated in the book (gcc 2.95.3, binutils: 2.10.1, glibc,
2.2.1).
>
> If yes:
>
> (a) What host system are you using?
>
> (b) Did you diverge from the directions in the book?
>
> If no:
>
> (a) Can someone out there suggest a known valid combination?
>
> I anticipate needing ssh, some web-server and snmp as application
requirements, so I figured it would be prudent to get the tool-chain working
with glibc as opposed to uClibc.
>
> -- Brian
>

--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
