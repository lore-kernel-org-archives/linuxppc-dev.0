To: <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sleep on Pismo, Ben's tree
References: <4v3ct9dhq8.fsf@pc203b.fzu.cz>
	<20020820144857.29286@smtp.adsl.oleane.com>
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 20 Aug 2002 23:50:11 +0200
In-Reply-To: <20020820144857.29286@smtp.adsl.oleane.com>
Message-ID: <4vy9b1b3os.fsf@pc203b.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<benh@kernel.crashing.org> writes:

> >> >'ve upgraded to
> >> >Linux version 2.4.19-ben0 (root@pbuk) (gcc version 2.95.4 20011002
> >> >(Debian prerelease)) #12 Wed Aug 7 14:27:13 CEST 2002
> >> >and since then my powerbook can't be waken up after sleep. It happened
> >> >three times -  the LCD is off so no error messages on console nor xmon
> >> >prompt can be seen. Log files are empty after reboot.
> >> >Any idea what's wrong?
> >> >cheers
> >> >        Jiri
> >>
> >> What is the latest tree that worked ?
> >>
> >> Ben.
> >
> >Hi Ben,
> >
> >I can confirm 2.4.19-rc3-ben0 (Jul 29) and earlier kernels are working
> >fine.
>
> Is it actually going to sleep ? (You can see the flashing light ?)

Yes it is. I can hear some hard disk activity after opening the lid
but that's all, the LCD remains dark and no beep occurs.

Jiri

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
