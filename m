MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: register_blk_dev seems to do nothing during boot for /dev/mtdblock0 
Date: Thu, 13 Mar 2003 13:21:46 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E3193823B@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@medcare.is>
To: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

If you are using devfs, it is called /dev/mtdblock/0 _not_ /dev/mtdblock0.

Do not forget to mount the devfs on boot.

Regards,

K.D.

> -----Original Message-----
> From: "Callebaut, Benoît" [mailto:benoit.callebaut@barco.com]
> Sent: 13. mars 2003 13:11
> To: Linuxppc-Embedded (E-mail)
> Subject: register_blk_dev seems to do nothing during boot for
> /dev/mtdblock0
>
>
>
> I placed the function devfs_find_handle after registering the
> filesystem in
> the read only block driver for MTD devices.
> It returns zero and I never see a mtdblock0 entry appaering
> in /dev/ Why
> must I use MAKEDEV to do that.
> Notes that I can use MAKEDEV in my case since I want to mount
> my cramfs
> filesystem at boot up.
>
> --------------------------------------------------------------
> --------------
> ------
> Benoit Callebaut
> Software Development Engineer
> Barco | Control Rooms
> Noordlaan 5, 8520 Kuurne, Belgium
>
> Tel 	+32(0)56 36 84 28
> Fax 	+32(0)56 36 86 05
>
> mailto:benoit.callebaut@barco.com
> http://www.barcocontrolrooms.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
