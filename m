Date: Mon, 12 Nov 2001 10:52:35 +0100 (CET)
From: Jonas Smedegaard <dr@jones.dk>
Reply-To: Jonas Smedegaard <js@debian.org>
To: "Jason E. Stewart" <jason@openinformatics.com>
Cc: <debian@jones.dk>, <linuxppc-dev@lists.linuxppc.org>,
	<debian-powerpc@lists.debian.org>
Subject: Re: IrDA-patched binaries
In-Reply-To: <87y9lc6h13.fsf@openinformatics.com>
Message-ID: <Pine.LNX.4.33.0111121047040.13469-100000@auryn.jones.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 11 Nov 2001, Jason E. Stewart wrote:

> "Jonas Smedegaard" <dr@jones.dk> writes:
>
> > I have made available kernel and irda-packages with the irda-hacks added
> > to make .
>
> I was totally thrilled to see this. Because of reiserfs, I need to
> compile my own kernel, so I grabbed the patches a couple of weeks ago.
> I just had time to look at them and it seems that parameters.h has
> changed a *lot* since this patch was made.

[cut]

> So it looks like the irda_pv_t has lost the *sp,*bp,s, and b fields
> since the patch was made. Since the primary change of the patch is to
> make the b and s fields into structs, I don't really have a clue how
> to procede.
>
> Can someone suggest anything?

Hi Jason,

My suggestion is have a look at the latest snapshot from
http://debian.jones.dk/auryn/kernels/patches/ with the irda patch
included: 2.4.15-pre1ben0rsync20011108irda20011030

I was lazy that day and didn't archive the snapshot without ida, but there
was no hackery, just a clean patch, so you can undo the pach if you
like...

I am no kernel hacker, so for the current situation what I do myself is
sit tight until someone pops up with a new diff and claims that it works.

Regarding my own testing: I managed to see my Nokia phone in
discovery-mode, but not communicate with it (using libgsm). Might be other
problems, I haven't succeeded recently on my Sony Vaio either, but have
had positive results way back (with 2.4.2 as I recall...).

 - Jonas

- --
Jonas Smedegaard (+45 40843136)          http://dr.jones.dk/~jonas/
Spiff ApS (= IT-guide dr. Jones ApS)     http://dr.jones.dk/
Debian GNU/Linux developer               http://people.debian.org/~js/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
