Subject: Re: problems with smbfs on 2.4.18 kernel (ppc)
From: Bastien Nocera <hadess@hadess.net>
To: Urban Widmark <urban@teststation.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.33.0203031810290.2722-100000@cola.teststation.com>
References: <Pine.LNX.4.33.0203031810290.2722-100000@cola.teststation.com>
Date: 05 Mar 2002 01:51:18 +0000
Message-Id: <1015293079.1830.55.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2002-03-03 at 17:28, Urban Widmark wrote:
>
> On 1 Mar 2002, Bastien Nocera wrote:
>
> > I'm having some problems with smbfs on ppc.
> > The attached file contains all the details. Am I doing something wrong?
>
> Has smbfs worked for you with previous versions? A patch was added late to
> 2.4.18 and it has caused a lot of crashes for people. I don't think it is
> related, but since you mention 2.4.18 ...

I never tried the previous versions of it.

> mount only prints the contents of /etc/mtab. What does /proc/mounts say?
> Do you have any kernel messages? (dmesg).

$ cat /proc/mounts  | grep smb
//kara/Backup1 /mnt/backup smbfs rw,file_mode=0755,dir_mode=0755 0 0

It seems to be mounted. dmesg says:
smbfs: Unrecognized mount option noexec

> The entry in mtab is written by smbmnt and one way to get this would be if
> the mount fails, but after smbmnt has written and then for some reason it
> fails to cleanup.

smb definetaly works, as I can browse it with the smb gnome-vfs module,
as well as smbclient. I'm failing to see why the /mnt/backup directory
just "disappears from there".

$ file /mnt/backup
/mnt/backup: can't stat `/mnt/backup' (No such file or directory).

This is weird. Do you have any more things I could try ?

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
