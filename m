Date: Thu, 11 Oct 2001 13:49:40 +0200
From: Olaf Hering <olh@suse.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.linuxppc.org,
	Herbert Duerr <duerr@sun.com>, kevin.hendricks@sympatico.ca
Subject: Re: Fwd: Re: bug in XFree86 4.1.0 with Rage 128 driver?
Message-ID: <20011011134940.A3720@suse.de>
References: <20011011025115.HNCD13446.tomts8-srv.bellnexxia.net@there> <3BC58640.ED96765F@iiic.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BC58640.ED96765F@iiic.ethz.ch>; from michdaen@iiic.ethz.ch on Thu, Oct 11, 2001 at 01:45:04PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 11, Michel Dänzer wrote:

> "Kevin B. Hendricks" wrote:
>
> > The bug was in XF 4.1.0 in Xrender.c not in OpenOffice
> >
> > The patch is attached.  They (XF4 guys) simply missed changing a variable
> > name and ended up using random garbage in an "if"
>
> Why does it work with the fbdev driver then?
>
>
> > Michel will you see that this makes it into the next XF 4.X release for us.
>
> I don't feel qualified to do that. Xpert@XFree86.Org is a mailing list which
> the author of this code and other very competent XFree86 hackers read, or if
> you're absolutely sure the fix is correct, please submit it to
> fixes@XFree86.Org .


keithp already put something in the CVS. It did not work with "ati", but
with fbdev (clgen).
The patch fixed it for me on the Pismo.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
