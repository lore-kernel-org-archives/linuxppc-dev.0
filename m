Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="============_-1298154425==_ma============"
Message-Id: <v04011700b29fb75fd5f7@[129.177.138.203]>
In-Reply-To: <3676EBC1.518C11F1@den.wantweb.net>
References: <3673C7D1.D0934DC7@mail.esiea.fr>
Date: Fri, 18 Dec 1998 09:00:29 +0100
To: Ron Nelson <rnelson@den.wantweb.net>
From: "Frank H. Pierce" <frank.pierce@hedb.uib.no>
Subject: Re: pre-R5 installation
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1298154425==_ma============
Content-Type: text/plain; charset="us-ascii"

Hi. I've installed pre-R5 on a PowerCenterPro by first doing a minimal
install of the R4 release and then installing the R5 rpms by hand. I guess
this is not a good solution but since my old second hd from a centris 610
crashed I thought what the h... It looks like it works fine. Some of the
rpms gave errors about not being able to execute the script but forcing it
with rpm -U --nodeps --force --noscripts I managed to squeeze them in
somehow:->

It boots fine with bootX and my old 2.1.130 kernel from my hd connected to
the Adaptec scsi card. X works with Windowmaker and egcs looks like it
compiles fine (still get seg.faults but that's nothing new for me)

The only problem I have is that imake and therefore xmkmf does not work.
This has given me a problem compiling xpm. If any one has compiled
libXpm.so.* I would love to get the Makefile you used. That might make
Netscape work to?




Frank Holton Pierce
frank.pierce@hedb.uib.no
--============_-1298154425==_ma============
Content-Type: text/enriched; charset="us-ascii"

<fontfamily><param>Geneva</param>Hi. I've installed pre-R5 on a
PowerCenterPro by first doing a minimal install of the R4 release and
then installing the R5 rpms by hand. I guess this is not a good
solution but since my old second hd from a centris 610 crashed I
thought what the h... It looks like it works fine. Some of the rpms
gave errors about not being able to execute the script but forcing it
with rpm -U --nodeps --force --noscripts I managed to squeeze them in
somehow:->


It boots fine with bootX and my old 2.1.130 kernel from my hd connected
to the Adaptec scsi card. X works with Windowmaker and egcs looks like
it compiles fine (still get seg.faults but that's nothing new for me)


The only problem I have is that imake and therefore xmkmf does not
work. This has given me a problem compiling xpm. If any one has
compiled libXpm.so.* I would love to get the Makefile you used. That
might make Netscape work to?




  </fontfamily>

Frank Holton Pierce

frank.pierce@hedb.uib.no

--============_-1298154425==_ma============--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
