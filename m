Message-ID: <39E0C4B7.612575E@denise.shiny.it>
Date: Sun, 08 Oct 2000 15:02:15 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: can't boot 2.4.0-t9
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can't boot kernel 2.4.0-test9 because it fails configuration
of my scsi cards (resource collisions). The hack of removing the
"return -EINVAL" I used in test7 doesn't work anymore.  Anyway,
I'm just curious to know why there are not such problems in 2.2.
How can I dump what it writes during boot ?  It's too fast, I
haven't the time to copy it by hand...

Another little thing: compilation fails because CONFIG_ADB_KEYBOARD
doesn't exist anymore, so I replaced it with CONFIG_PPC in
devices/input/keybdev.c. I also had to compile with CONFIG_PMAC_PBOOK
enabled, otherwise it complains the lack of the function
mediabay.c:media_bay_set_ide_infos() in ide-pmac.c

(blue-G3/350, 2 Adaptec 2930U in busses 2 and 3)

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
