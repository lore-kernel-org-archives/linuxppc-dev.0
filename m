Message-Id: <199901152332.RAA07320@www.cedarnet.org>
Date: Fri, 15 Jan 1999 17:33:35 -0600
Subject: Re: kernel 2.2.0-pre4
From: "Kevin Puetz" <kp11901@cedarnet.org>
To: fritz.wettstein@tamedia.ch, linuxPPC-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This happened to me too, though only when using a quik name for it (as 
opposed to typing the full path/command. I'm going to try some more to debug
this, but...

Typing this same command at the quik prompt did not have the problem. Any
ideas? G3/233 DT (rev 1), quik 1.3.1,

My command is

image=/boot/vmlinux_010799
    label=benh
    root=/dev/hda7
    append=" video=atyfb:vmode:17,cmode:16"

--
+--------------------------------------------------------------------+
|            .-'''''-.       Kevin Puetz                             |
|          .'   _/|   `.                                             |
|         :   =/_/      :    kp11901@cedarnet.org -preferred         |
|        :   _/ |        :   Kevin.Puetz@039-server.pls.uni.edu      |
|       (\  /  ,|        :   webmaster@039-server.pls.uni.edu        |
|        \\/^\/||__     :                                            |
|     _/~`~`""~`"` \_ .'  "Could you please continue the petty       |
|  __/  -'/  `-._ `\_\__   bickering?  I find it - most intriguing." |
|/     /-'`  `\   \  \-.\    --Data, STTNG, "Haven"                  |
+--------------------------------------------------------------------+

----------
>From: fritzwe.linux@tamedia.ch
>To: linuxppc-user@lists.linuxppc.ORG
>Subject: kernel 2.2.0-pre4
>Date: Fri, Jan 15, 1999, 3:29 AM
>

>
> Hi,
>
> I'm trying this kernel I've found at http://calvaweb.calvacom.fr/bh40
> because of the support for my AHA2940UW and the 3-button mouse I've
> missed so badly in 2.1.25.
>
> The line "Welcome to Linux, kernel 2.2.0-pre4 booting..." appears and
> that's it.
>
> I've put vmlinux into the System Folder.
>
> BootX 1.0.1 is configured as follows:
>   boot device: sdc4 (thats the UW-scsi drive where the System
>                      Folder is located)
>   More kernel arguments: root=/dev/sda4 swap=/dev/sda5 vmode=14 cmode=8
>                          (/dev/sda is attached to the internal scsi).
>
> The Mac is a 7200/90
>
> Fritz
> ----------------------------------
> Date: 15-Jan-99
> Time: 09:50:45
>
> TA-Media AG                             Phone +41 1 248 4732
> Telematik                                 Fax +41 1 248 5152
> Fritz Wettstein
>
> This message was sent by XFMail
> ----------------------------------
>
> [[ This message was sent via the linuxppc-user mailing list. Replies are ]]
> [[ not forced back to the list, so be sure to  Cc linuxppc-user  if your ]]
> [[ reply is of general interest. To unsubscribe from linuxppc-user, send ]]
> [[ the message 'unsubscribe' to linuxppc-user-request@lists.linuxppc.org ]]

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
