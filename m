Message-ID: <8B43573754BCD211B5970008C74B8126010F7648@RENEXCH3.rennes.thmulti.com>
From: Paugam Luc <PAUGAML@thmulti.com>
To: "'Jo-Ellen F. Mathews'" <joellen@absoval.com>
Cc: "'linux-ppc Mailing-List'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Small Web Server
Date: Wed, 16 Aug 2000 17:13:48 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Have a look at http://www.boa.org. It is thin and very fast (really
dedicated to embedded platforms).

Boa is a single-tasking HTTP server. That means that unlike traditional web
servers, it does not fork for each incoming connection, nor does it fork
many copies of itself to handle multiple connections. It internally
multiplexes all of the ongoing HTTP connections, and forks only for CGI
programs (which must be separate processes), automatic directory generation,
and automatic file gunzipping. Preliminary tests show Boa is capable of
handling several thousand hits per second on a 300 MHz Pentium and dozens of
hits per second on a lowly 20 MHz 386/SX.

Hope this help.

Luc
> -----Original Message-----
> From:	Jo-Ellen F. Mathews [SMTP:joellen@absoval.com]
> Sent:	Wednesday, August 16, 2000 4:54 PM
> To:	linuxppc-embedded@lists.linuxppc.org
> Subject:	Small Web Server
>
>
> Howdy Folks!
>
> I'm working on the RPX Lite, and I'm exploring my options for a small web
> server.  I downloaded the "GoAhead" web server, and I'm testing it out on
> my host machine (Intel) first to become familiar with it and to see how
> large the binary is before giving it a try on the RPX.
>
> In the meantime, I'd thought I'd probe the list for suggested web servers
> that others may have tried on embedded boards and where to find such web
> servers.  Any direction to good documentation would also be greatly
> appreciated.
>
> Thanks in advance!
> Jo-Ellen Mathews
>
> ---------------------------------------------------------
> Jo-Ellen F. Mathews
>
> AbsoluteValue Systems      Web:    http://www.linux-wlan.com
> P.O. Box 941149            e-mail: jo-ellen@linux-wlan.com
> Maitland, FL 32794-1149    Phone:  407.644.8582
> USA                        Fax:    407.539.1294
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
