Message-ID: <3BEF9DA6.14AF8E49@iiic.ethz.ch>
Date: Mon, 12 Nov 2001 11:00:06 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Reply-To: daenzer@debian.org
MIME-Version: 1.0
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: Jonas Smedegaard <js@debian.org>, debian@jones.dk,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: IrDA-patched binaries
References: <Pine.LNX.4.33.0111012312360.888-100000@auryn.jones.dk> <87y9lc6h13.fsf@openinformatics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Jason E. Stewart" wrote:
>
> "Jonas Smedegaard" <dr@jones.dk> writes:
>
> > I have made available kernel and irda-packages with the irda-hacks
> > added to make .
>
> I was totally thrilled to see this. Because of reiserfs, I need to
> compile my own kernel, so I grabbed the patches a couple of weeks
> ago. I just had time to look at them and it seems that parameters.h
> has changed a *lot* since this patch was made.
>
> >From BenH's latest kernel:
>
> typedef union {
>         char   *c;
>         __u32   i;
>         __u32 *ip;
> } irda_pv_t;

Yup, 2.4.15-pre2 has my better fix. :)

Now we're working on fixing macserial such that the 'cat /dev/ttyS1
trick' isn't needed anymore...


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
