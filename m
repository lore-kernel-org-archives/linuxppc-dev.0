Message-ID: <37E5B000.8EFFCC8@loomer.com>
Date: Sun, 19 Sep 1999 20:54:43 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: Tsuneya Watabe <twatabe@shore.net>
CC: linuxppc user <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Can't build pcmcia-cs 3.1.0?
References: <Pine.LNX.3.96LJ1.1b7.990920122926.1208A-100000@lydia.concorde.gr.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul?  Any ideas?

Hugh

Tsuneya Watabe wrote:

> On Sun, 19 Sep 1999, Hugh Caley wrote:
>
> > Trying to build the latest pcmcia-cs.  Error below; seems to be hanging on
> > "spin_lock_irqsave(&s->lock, flags);
>
> I experienced the same error under kernel 2.2.12 but the same 3.1.0
> was well compiled under 2.2.10. I don't know what is wrong with the
> source tree of 2.2.12 which is from rsync-ed Paul's tree.
>
> Tsuneya Watabe
> --
>      ==================   twatabe@shore.net   ====================
>      Finger twatabe@world.std.com for PGP Public Key; ID: 1B38AC95
>      Fingerprint: B6 C5 34 C8 53 1C A7 39  2A 09 EF 17 E4 0D B9 CA

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
