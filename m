From: "Jim Lewis" <jlewis@mvista.com>
To: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Formatting JFFS2 Flash
Date: Thu, 14 Mar 2002 07:30:28 -0600
Message-ID: <NDBBLNMCOLBBHLKBOLFEKEJADMAA.jlewis@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <A1C99F4731CAD111BA5400A024FC3B0CBE047C@ESBILMA01EDCGE>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Did you remember to erase the flash first with:
	erase /dev/mtd0
Then "xxd /dev/mtd0" should show all FF's. You can't write
successfully unless it is erased first. Forgive me if I am stating the
obvious :)

-Jim Lewis

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> Billalabeitia, Jose Carlos (IndSys, GEPM)
> Sent: Thursday, March 14, 2002 2:34 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Formatting JFFS2 Flash
>
>
>
> Hi Alex:
>
> First of all, thank you for your answer. You wrote:
>
> > Did you initialise the FS with
> > cat jffs2.image > /dev/mtd0
> > before you tried to mount /mtdblock0 ?
>
> 	I tried it in two ways, and in both of them
> I got the same result:
>
> 	1.- By flashing "jffs2.image" directly to
> 	    its location address.
>
> 	2.- cp jffs2.image /dev/mtd0
>
> and then mounting it into the system.
>
> > Did you use an empty directory with mkfs.jffs2
> > to make your jffs2.image?  This doesn't work
> > - you end up with a 0 length jffs2.image!
>
> 	No, the directory is not empty.
>
> 					Thank you
> 						Billa
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
