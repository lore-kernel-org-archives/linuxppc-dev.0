Message-Id: <20010403040535.Postino-018013@smtp01.highway.ne.jp>
Date: Tue, 3 Apr 2001 04:05:35 +0900
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Denis <denis.muquardt@chello.be>,
	<linuxppc-dev@lists.linuxppc.org>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 3dfx kernel patch
In-Reply-To: <Pine.BSF.4.32.0104021003480.40704-200000@shell.unixbox.com>
References: <20010403010620.Postino-017265@smtp01.highway.ne.jp>
 <Pine.BSF.4.32.0104021003480.40704-200000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: 3dfx kernel patch
Date: Mon, 2 Apr 2001 10:05:35 -0700 (PDT)
cc: Denis <denis.muquardt@chello.be>, <linuxppc-dev@lists.linuxppc.org>

>
>
> On Tue, 3 Apr 2001, Kaoru Fukui wrote:
>
> > >video=tdfx:
> >
> > The name is worng,It's tdfxfb.
> > But I don't have the card.
>
> No, the name is correct.  Arguments for the tdfxfb driver use
> "video=tdfx:...."
>
> The attatched patch will fix the "mirrored" text, but you *must* boot with
> "video=tdfx:noaccel" as this patch doesn't have the character endian
> swapping.

Thanks,Ani for your patch.
I will add the patch next kernel.

Denis  sorry I didn't know that.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
