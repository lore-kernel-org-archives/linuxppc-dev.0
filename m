Message-ID: <XFMail.010430101946.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.21L.0104291944440.17913-100000@unix47.andrew.cmu.edu>
Date: Mon, 30 Apr 2001 10:19:46 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Subject: Re: 9.1 Gbyte SCSI Drive
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> version 0.7a3 (18 February 1998)
>>
>> [root@Jay linux]# /sbin/pdisk -i
>> Top level command (? for help): e /dev/sdb
>> Edit /dev/sdb -
>> Command (? for help): i
>> map already exists
>   ^^^ seems to suggest that you did not use dd to zero your partition map
> before trying this experiment.

Yes, I used a previously partitioned disk, but I use the same method
with clean discs with no problems. Ok, I'll try with a dd'ed one and
I'll make you know.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
