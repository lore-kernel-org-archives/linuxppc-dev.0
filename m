Message-ID: <009601c24efa$32b61720$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Fw: Password on ELDK nfs booting 
Date: Thu, 29 Aug 2002 10:20:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Sorry, I sent the following mail with the wrong encoding to this list.

----- Original Message -----
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "leeyang" <leeyang@ycig.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, August 28, 2002 7:01 PM
Subject: Re: Password on ELDK nfs booting


>
> Hi
> I succeeded in login after installing the tinylogin.
> I plan to use tinylogin.
>
> >
> > I can login with eldk,the only problem I encountered
> > is that  /eldk/ppc_8xx/dev/ is alomost empty!only 3 unimportant
> > files,when installed with eldk installl scripts.
> > so when I boot with nfs it reports "can not create console".
> > After I cp some dev from my host,it is ok now:)
> >
> Execute /mnt/cdrom/ELDK_MKDVICE instead, as the readme said.
>
> > The other thing is can not telnet to the NFS board,it
> > always says
> > "
> > Trying 192.168.1.3...
> > Connected to 192.168.1.3 (192.168.1.3).
> > Escape character is '^]'.
> > telnetd: All network ports in use.
> > "
> > then close connection.
> >
> > anybody run into the same thing?
> >
> In my case telnet is OK even when the serial port doesn't work.
> Please check that your files have proper owner.
> Excute /cdrom/mnt/ELDK_FIXOWNER if not on /opt/eldk directory.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
