Message-ID: <3BD841FC.6020004@capflow.com>
Date: Thu, 25 Oct 2001 18:46:52 +0200
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: owner-linuxppc-embedded@lists.linuxppc.org
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Root-NFS: Server returned error -13
References: <3BD83F82.BE5C66A5@disca.upv.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>torreta mountd[20966]: Blocked attempt of 158.42.50.66 to mount
>/tftpboot/158.42.50.66
>....
>
>The /etc/exports looks like:
>....
>/home/ddandres/export 158.42.50.66(rw,no_root_squash)
>....
>
/etc/exports obviously doesn't allow 158.42.50.66 to access
/tftpboot/158.42.50.66

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
