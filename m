Message-ID: <81A66F72DCACD511B0600002A551BFCB02ABC2C8@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: register_blk_dev seems to do nothing during boot for /dev/mtdbloc
	k0
Date: Thu, 13 Mar 2003 14:10:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I placed the function devfs_find_handle after registering the filesystem in
the read only block driver for MTD devices.
It returns zero and I never see a mtdblock0 entry appaering in /dev/ Why
must I use MAKEDEV to do that.
Notes that I can use MAKEDEV in my case since I want to mount my cramfs
filesystem at boot up.

----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
