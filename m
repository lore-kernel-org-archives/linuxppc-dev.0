Message-ID: <001001c03dba$2bbd1fc0$2801a8c0@thanhnguyen>
Reply-To: "jari.nguyen" <jari.nguyen@serialsystem.com.sg>
From: "jari.nguyen" <jari.nguyen@serialsystem.com.sg>
To: "Pawel Zawora" <pzawora@fideltronik.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <39F56F56.1C66A666@fideltronik.com>
Subject: Re: Rom FS
Date: Tue, 24 Oct 2000 19:58:57 +0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> I use kernel 2.2.13 for MPC 823
> I would like to mount rom file system as root, but kernel is unable to
> recognize partition's  type.

you should check configuration by type:
    make xconfig
choose filesystem support ROMFS.
then replace your file with the ramdisk.image.gz
in the mbxboot directory
    make zImage.initrd
burn it into rom, and go to the kernel image to boot

> Anybody try to mount rom fs as root?  Is it possible?
It's ok.

> Is possible to use compressed rom file system?

It's possible, but you have to build your own one,
because it depend on what you want to do, or you'd
try to look at qslinux.org

hope to help,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
