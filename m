To: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging Init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Dec 2002 14:52:11 PST."
             <0509218DDAD7D6118055006008F6D5F6A1E3A2@postal.viasat.com>
Date: Wed, 11 Dec 2002 01:33:32 +0100
Message-Id: <20021211003337.66353C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0509218DDAD7D6118055006008F6D5F6A1E3A2@postal.viasat.com> you wrote:
>
> I figure I am at the last stage in boot (I hope). I am however having an
> issue that I was hoping someone
> may shed some light on. I am having a hanging init.
>
> 1) I rebuilt busybox and here are the dependencies:

Ummm... why did  you  do  that?  The  ELDK  already  cntains  BusyBox
binaries, both dymnamically and staically linked.

> 3) Here is the output from PPCBoot. It looks like NFS mount was successfull.
> I am using

...and if you're using the root filesystem over NFS  you  don;t  need
any busybox at all.

If  you're   looking   for   a   ramdisk   environment,   check   for
images/pRamdisk in your ELDK directory - there is a SELF RPM included
with ELDK 2.0.

>    NFS mount server that run in user space NOT kernel. Don't know of this
> makes any difference,
>    but I was able to NFS mount the directory from another machine.
> 	mount -t nfs 172.25.4.55:/tftpboot/powerpc/ /mnt/nfs.

Did you run the ELDK_MAKEDEV and ELDK_FIXOWNER sripts  as  documented
in section "7. Mounting Target Components via NFS" ?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You're too beautiful to ignore.  Too much woman.
	-- Kirk to Yeoman Rand, "The Enemy Within", stardate unknown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
