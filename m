Message-ID: <00dd01c24e79$d67004b0$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "leeyang" <leeyang@ycig.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20020827132459.6F0741182F@denx.denx.de> <009e01c24e61$9bbfd5b0$1a11efcb@industrialDiv.hanasys.co.kr> <000701c24e73$3227a620$cc00a8c0@ycigrnd.ycig.com>
Subject: Re: Password on ELDK nfs booting 
Date: Wed, 28 Aug 2002 19:01:11 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
I succeeded in login after installing the tinylogin.
I plan to use tinylogin.

>
> I can login with eldk,the only problem I encountered
> is that  /eldk/ppc_8xx/dev/ is alomost empty!only 3 unimportant
> files,when installed with eldk installl scripts.
> so when I boot with nfs it reports "can not create console".
> After I cp some dev from my host,it is ok now:)
>
Execute /mnt/cdrom/ELDK_MKDVICE instead, as the readme said.

> The other thing is can not telnet to the NFS board,it
> always says
> "
> Trying 192.168.1.3...
> Connected to 192.168.1.3 (192.168.1.3).
> Escape character is '^]'.
> telnetd: All network ports in use.
> "
> then close connection.
>
> anybody run into the same thing?
>
In my case telnet is OK even when the serial port doesn't work.
Please check that your files have proper owner.
Excute /cdrom/mnt/ELDK_FIXOWNER if not on /opt/eldk directory.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
