Message-ID: <028801c28ed5$49cbdab0$993810ac@cn.utstar.com>
From: "qi zhaoling" <zlqi@utstar.com>
To: "Anders Blomdell" <anders.blomdell@control.lth.se>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <C5555DFE-FAC6-11D6-96A7-0003931C2BFA@control.lth.se>
Subject: Re: ramdisk crash
Date: Mon, 18 Nov 2002 15:37:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anders,
    thanks for your commit.
    yes, I am sure i have done it .
    following is my configuration file :

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS_FS=y
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set


----- Original Message -----
From: "Anders Blomdell" <anders.blomdell@control.lth.se>
To: "qi zhaoling" <zlqi@utstar.com>
Sent: Monday, November 18, 2002 3:24 PM
Subject: Re: ramdisk crash


> > hi ,
> >      I use the SELF from the denx corp to bring up my embedded linux.
> >  the PPCBoot and Kernel bootup sucessfully , but when i used initrd
> >  to mount ramdisk , the system crashed . but if i use NFS to mount =
> >  ramdisk
> >  , it's fine .
> >
> >  i am sure:
> >
> >  1. I build linux kernel according to SELF
> And you did remember to enable ext2 filesyste (CONFIG_EXT2_FS=y)?
>
> /Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
