Message-ID: <XFMail.20010808104837.medp@primagraphics.co.uk>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <3B705B22.366AE18F@adtran.com>
Date: Wed, 08 Aug 2001 10:48:37 +0100 (BST)
From: Mark Powell <medp@primagraphics.co.uk>
To: Ron Flory <ron.flory@adtran.com>
Subject: Re: Strange bootpd behavior (server side)
Cc: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>,
	Kevin Fry <kevin@carts.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 07-Aug-2001 Ron Flory wrote:
>
>   it sounds like 'fun with PAM' that causes similar problems with my
>  TFTP server.  I need to write a simple inetd replacement (sans PAM)
>  just for TFTP, so we don't get killed by the delays caused by PAM
>  authorization checks.

You might like to look at the tcpserver program, part of the ucspi-tcp
package http://pobox.com/~djb/ucspi-tcp.html

It monitors a given port, like inetd and runs a given program handle
connections.


--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, medp@primag.co.uk, http://www.primag.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
