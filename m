Message-ID: <3670DD32.444E8336@mail.dotcom.fr>
Date: Fri, 11 Dec 1998 10:52:06 +0200
From: Cedric Moreau <cedric.moreau@mail.dotcom.fr>
Reply-To: cedric.moreau@mail.dotcom.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux kernel and Sony GDM 19500
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There is a trouble with the GDM 1950, because it uses the video mode 17,
and in this mode the sync are inverted. The GDM 1950 need uninverted
sync, so i need to patch the kernel (to replace the inverted define into
a 0).
Is there a way to include the patch into the kernel ? (because if i
install linux from scratch, i need an other monitor because this one is
monofrequency so it can only use video mode 17) ?

        Cedric Moreau
(powerbase 200, 48 Mb, 3.2Gb, 19" GDM 1950, kernel 2.1.129, RedHat 4)


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
