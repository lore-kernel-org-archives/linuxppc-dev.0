To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Oct 2001 22:05:11 +1000."
             <15312.5879.511865.946406@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2001 15:28:45 +0200
Message-Id: <20011019132850.CA20710CCC@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <15312.5879.511865.946406@cargo.ozlabs.ibm.com> you wrote:
>
> Other platform maintainers can use a wrapper or not as they choose.
> For consistency and simplicity it would be nice if there was a
> standard register assignment on entry, for example having the physical
> address of the bi_recs in r3, but that is not essential.
>
> We should all agree on a comment set of bi_rec tags and the format for
> each type of entry.  And I like Ben's suggestion of keeping the bi_recs
> around.

Both is fine for me...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A failure will not appear until a unit has passed final inspection.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
