Message-ID: <3BD843F8.E00D68B6@mvista.com>
Date: Thu, 25 Oct 2001 11:55:20 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Root-NFS: Server returned error -13
References: <3BD83F82.BE5C66A5@disca.upv.es>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David de Andrés Martínez wrote:
>
> Hi all,
>
> I'm trying to boot from NFS but I can't access the directory.
> Root-NFS: Server returned error -13 while mounting
> /tftpboot/158.42.50.66

> torreta mountd[20966]: NFS mount of /tftpboot/158.42.50.66 attempted

> The /etc/exports looks like:
> ....
> /home/ddandres/export 158.42.50.66(rw,no_root_squash)
> ....

If you notice the kernel is attempting to mount "/tftpboot/158.42.50.66"
while you have "/home/ddandres/export" as your only export.

What you need to do is set a symbolic link from /tftpboot/158.42.50.66
to /home/ddandres/export.  (Depending on the nfs server that might be
enough..  if not you will need to add "/tftpboot/158.42.50.66" to your
/etc/exports file..

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
