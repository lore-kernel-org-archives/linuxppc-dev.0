From: Konstantinos Margaritis <kmargar@cc.uoa.gr>
To: linuxppc-dev@lists.linuxppc.org
Subject: g200 hw 3d on powerpc
Date: Mon, 31 May 1999 03:51:52 +0300
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99053103585003.30874@proton>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----

   Hi,
   If anyone noticed, the g200-dev project is proceeding along very nicely
(http://lists.openprojects.net/mailman/listinfo/g200-dev), and it's about
writing a hw OpenGL driver for the Matrox G200 card. Now I don't really
care about having a video card that will only work on linux (I think it
does already on powerpc, using matroxfb) and both mac-on-linux and
shapeshifter could make a mac card unnecessary even.
   I talked to some g200-dev developers and the opinions were divided. In
particular, one thinks that fbdev+g200-glx will work, another one does not.
   The point is if a user-mode 3d driver, could access the raw hardware
thru a fb device. I understand that the framebuffer gets mmap'd but what
about the registers?
   Anyway, I hope you will see it's an important issue here. If this
just works on one system, chances are that there will be more willing to
buy the g200 (and even g400 which is also open-specs).

- --
Konstantinos Margaritis
-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia
Charset: noconv

iQCVAwUBN1HeyvalfJok8qABAQGA5gP/dyDiQxixRc8ntxx/MPgHU7MR6sl78aVq
EgXrfpsYb5p4kjCLPPcUpGIbU4ry+I/ManoebODIeQIBhgmilo8npp39l+sgNfrW
+l6hXjKWSTHU+4Pym42VtodxbDBpvRb6NpHPNfbvi9USLL9jOzjrUPJdz54nBfYt
NMc+zCrbmNQ=
=kLLB
-----END PGP SIGNATURE-----

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
