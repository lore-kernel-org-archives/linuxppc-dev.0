Message-ID: <3A9EC368.23D57EFD@mvista.com>
Date: Thu, 01 Mar 2001 16:47:20 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Arturo Nunez <artnpp@cs.ucf.edu>
Cc: ppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to enable 2 ethernet ports ??
References: <200103012140.QAA15546@iris.cs.ucf.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arturo Nunez wrote:

>         These Board has 2 ports:
>         10 and 100 mbps

The 10 Mbit port is SCC1, the 10/100 is FEC.  Just select them
in the configuration process.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
