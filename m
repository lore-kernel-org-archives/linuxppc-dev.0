Message-ID: <XFMail.000621153237.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.21.0006200827480.1155-100000@pegmatite.iu13.k12.pa.us>
Date: Wed, 21 Jun 2000 15:32:37 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: Slow Adaptec
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I've just mounted an Adaptec 2930 SCSI ultra-narrow controller into my
"new" G3. It works fine with Linux, but it refuse to go at 20MB/s as
it should. At boot time it tells 10MB/s and it reaches about 9.5MB/s
raw transfer. I connected a 9GB IBM U2W harddisk and it correctly runs
at 20MB/s with MacOS. It's the only device on the SCSI bus.
Is there any boot parameter or so to make it work in "ultra" mode ?

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
