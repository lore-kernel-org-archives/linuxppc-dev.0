Message-ID: <125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org>
Subject: Re: temp.c and cputable.c issues
Date: Thu, 15 Jan 2004 09:19:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Wed, Jan 14, 2004 at 03:10:18PM -0700, Tom Rini wrote:
>
> > There are errata documents from Motorola that tell you not to use the
> > TAU on any 745x CPU.  The omission of this flag is intentional.
>
> what's about this documents ?, if TAU is disabled what's the right way
> to fetch thermal infos for 745x based CPUs ?, any workaround or
suggested
> url to start from ?

What's your computer model ?
You can try to do a
`find /proc/device-tree -name fan|grep -v aliases`

You may have an external chipset used to check temperatures and control
the fan.

--
Colin
Ne disez pas disez, mais disez dites


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
