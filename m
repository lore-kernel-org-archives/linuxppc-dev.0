From: jlquinn@us.ibm.com
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <852568D3.006FB564.00@D51MTA03.pok.ibm.com>
Date: Tue, 2 May 2000 16:20:11 -0400
Subject: Re: advansys
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stay tuned.  I've gotten the advansys driver basically working on a wide
card (970UW).  I expect we can get the last few details ironed out and
integrated soon.  Tom Rini is planning to look at narrow cards.  I've also
started to look at it but am working blind since I don't have the hardware.

It is apparently all endian issues, so things should fall in place fairly
quickly.  The guy who wrote the driver, Bob Frey, has been giving me a lot
of help.

How many people out there have Advansys cards gathering dust because the
driver isn't working yet?

Jerry Quinn



Giuliano Pochini <pochini@denise.shiny.it>@lists.linuxppc.org on 05/02/2000
08:57:03 PM
Does Advansys SCSI cards work with linux-ppc ?  In their homepage they say
that cards works on x86 and alpha systems, but there's nothing about MACs.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
