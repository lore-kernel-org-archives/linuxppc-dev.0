Message-ID: <39997091.8CD3B51A@pop.agri.ch>
Date: Tue, 15 Aug 2000 18:32:18 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 ... works
References: <3999AC2A.1057C171@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> I compiled 2.4 for the first time.
>
> At boot it complains: "PCI device 01:02.0 non available
> because of resource collisions" and again for 01:03.0.
> They are my 2 SCSI controllers... and it doesn't boot.
> I patches pci.c to ignore the error and now it seems to

Still ? I try it in few hours, AHA2940UW...

> work fine, but I don't like that hack.
> PPP doesn't work. Do I need a more recent pppd ?

The latest is, last week or so, 2.4. ftp://linuxcare.com.au/pub/ppp
Works on both, stable and devel.

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
