Message-ID: <3F154239.C333EE33@prodys.net>
Date: Wed, 16 Jul 2003 14:16:57 +0200
From: Pedro Parrilla <pparrilla@prodys.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Samba shares on a Jffs Filesystem...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hi!

    Could anyone help me about a problem with Samba...? We have a
folder on a Jffs Filesystem on our second flash partition (1 MB size and

800 KB free); this folder is shared by our samba daemon and it can be
accesed from any Windows Pc in our Lan... reading a file works fine, but

if you try to copy a file greater than 200KB, Windows File Explorer
shows the following message:

    Cannot create the file FILENAME: Cannot read from the source file...

(This a translation from spanish Windows;-)

    Besides, it is possible to copy several files, from any Windows Pc,
up to 800 KB, but this files have to be smaller than 200 KB size.
    Of course,from console, you can copy a file greater than 200 KB into

that folder without problem...

    Do you any experience in this regard?

    Than you in advance.

    Ciao.

    Pedro Parrilla Jimena                          Prodys S. L.
    R&D,Embedded Systems                   Trigo,54
    e-mail:pparrilla@prodys.net             Leganes(Madrid)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
