Date: Wed, 29 Mar 2000 21:47:50 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC and Pismo Powerbook
Message-ID: <20000329214750.E4054@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <20000329184718.027924@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000329184718.027924@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, Benjamin Herrenschmidt wrote:

>
> On Wed, Mar 29, 2000, Olaf Hering <olh@suse.de> wrote:
>
> >I had never problems with my faked system folder, I move it around, to
> >CDs, to netatalk servers and where ever I want. This can be a "feature"
> >of OS9 that it doesn't remove the information, I don't know.
> >
> >What makes this blessing so special??
>
> The "blessing" is a combination of two things:
>
>  - The directory ID of the "blessed" folder is written somewhere in the
> disk catalog (I think in the MDB, I don't remember for sure)
>
>  - Valid boot blocs are written to bloc 0 and 1 of the volume
>
> OF may still be able to boot if the bootblocs are not present (but miBoot
> can't).

In this case it is for the new world machines and as I said it works
always and ever. I drag it from the partition to a netatalk volume, go
to another mac and drag the folder into the Linux boot partition and it
is shown as a system folder. We have only OS9 here, the older B&W
machines can not be bootet from a OS 8.5 CDs and the original CDs are
gone. So I can't test it with OS 8.6.

I will post a smi the next days, I guess when you open it and drag it
onto another partition it will be bootable.

Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
