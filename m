Message-Id: <200012100836.eBA8a3W15391@denx.local.net>
To: Subodh Nijsure <SNijsure@SkyStream.com>
cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Connecting to powerpc target via wiggler. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 09 Dec 2000 20:30:38 PST."
             <B25E2E5A003CD311B61E00902778AF2A0148B611@server1.skystream.com>
Date: Sun, 10 Dec 2000 09:36:02 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B25E2E5A003CD311B61E00902778AF2A0148B611@server1.skystream.com> you wrote:
>
> Has anybody been successful in connecting to the powerpc board
> using the BDM wiggler from MACRAIGOR system?

AFAIK the wiggler comes with its own software; I don't know if a  GDB
compatible version is available.

> I have gdb-5.0 which I have compiled with OCD and BDM4GDB targets.

The BDM4GDB target will only work with the BDM4GDB adapter;  see  the
BDM4GDB project at Sourceforge.

> I have also tried building the BDM4GDB and connecting using
> that target, without any luck.

There is very little chance that this might work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
