Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <waite@skycomputers.com>
To: jeffrey.d.kowing@nasa.gov
Subject: Re: NFS root manipulation without being superuser?
Date: Fri, 15 Nov 2002 13:48:11 -0500
References: <15829.8892.699280.307557@igor.jsc.nasa.gov>
In-Reply-To: <15829.8892.699280.307557@igor.jsc.nasa.gov>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <200211151348.11492.waite@skycomputers.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


you could export the fs from the dev host as no_root_squash an insecure
for example
/home   *(rw,insecure,no_root_squash)

That will allow the embedded host to modify files on the NFS filesystem as
root. Does tha accomplish what you need?

Thanks
Brian

On Friday 15 November 2002 11:37 am, Jeff Kowing wrote:
> During embedded system developement, I use an NFS root mounted
> filesystem that is exported from my development workstation.  I am
> constantly having to "su root" on my development workstation when I
> want to manipulate the root filesystem for the target machine. I was
> wondering if anyone uses a safer technique that allows manipulation of
> the target's root filesystem without being root on the development
> workstation.
>
> I know I could make the exported filesystem all be owned by my
> unprivledged user and group name, but I would like the target machine
> to see those files as owned by root as would normally be the case.
>
> Anyways, I was just curious if I am missing out on some cool technique
> that other's use that I am not brilliant enough to come up with on my
> own.
>
> Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
