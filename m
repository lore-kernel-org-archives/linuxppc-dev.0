Date: Sun, 3 Mar 2002 18:28:03 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problems with smbfs on 2.4.18 kernel (ppc)
In-Reply-To: <1015002703.765.74.camel@dozo>
Message-ID: <Pine.LNX.4.33.0203031810290.2722-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1 Mar 2002, Bastien Nocera wrote:

> Hi,
>
> I'm having some problems with smbfs on ppc.
> The attached file contains all the details. Am I doing something wrong ?

Has smbfs worked for you with previous versions? A patch was added late to
2.4.18 and it has caused a lot of crashes for people. I don't think it is
related, but since you mention 2.4.18 ...

mount only prints the contents of /etc/mtab. What does /proc/mounts say?
Do you have any kernel messages? (dmesg).

The entry in mtab is written by smbmnt and one way to get this would be if
the mount fails, but after smbmnt has written and then for some reason it
fails to cleanup.

/Urban


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
