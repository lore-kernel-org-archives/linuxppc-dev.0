Message-ID: <39E7C1A4.BBA004ED@denise.shiny.it>
Date: Fri, 13 Oct 2000 22:15:00 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: can't boot 2.4.0-t9
References: <39E0C4B7.612575E@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> I can't boot kernel 2.4.0-test9 because it fails configuration
> of my scsi cards (resource collisions). The hack of removing the
> "return -EINVAL" I used in test7 doesn't work anymore.  Anyway,
> I'm just curious to know why there are not such problems in 2.2.
> How can I dump what it writes during boot ?  It's too fast, I
> haven't the time to copy it by hand...

Ok, I've just hacked pci.c from test7 to compile in test9. It still
doesn't work.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
