Message-ID: <F14441D40E5AD3118886005004607AD10BDD62@mail.libra.de>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Cc: "'Olaf Hering'" <olh@suse.de>
Subject: Status of HFS+ Support
Date: Mon, 31 Jul 2000 08:35:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I hope you dont mind me posting this here,
I can't imagine a better place right now.

In cooperation with Suse (thanks to Olaf Hering and other People at Suse),
we have set up an CVS repository for the hfsplus stuff.
Olaf Hering, some Suse internal and I have write access and there is an
anonymous access,too.

The hfsplus tools _shall_ work like the hfsutils (from rob@mars.org)
once I get so far. Currently Im stuck in grasping the B*-Tree structure
and it may take a while until I have presentable progress. I can only
spare some hours at the weekend (and my wife would like to get some time,
too) or when traveling to work by train.

Meanwhile everybody interested may help me in some of the following ways:

	Provide HFS+ formatted images with known content.
	(via mounting a ramdisk in MOL, thanks to BenH for this tip)

	Review my code (The code for the allocation bitmap does'nt work,
	but I dont know why, yet).

	Help pushing this thing foreward.

Whoever is interestet in the anoymous access can mail Olaf Hering or me.
In case there is overwhelming interest I'll post it here
I'll be happy to accepts comments and diffs agains the cvs tree.

Greeting,

|       |                  Klaus Halfmann       khalfmann@libra.de
|       |				  			(aka Hasi)
|    i  | --.  r---  -- |  Libra Software GmbH  Tel +49 (0)621 41997-0
|    |  b-- |  |    a-- |  Erzbergerstr. 17     Fax +49 (0)621 41997-30
L--- |  --- |  |    .---.  68165 Mannheim

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
