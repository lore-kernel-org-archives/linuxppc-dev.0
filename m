Message-Id: <200110102034.QAA07470@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port: BI RECS
Date: Wed, 10 Oct 2001 16:24:54 -0400
References: <85256AE1.006F4CE8.00@pine.cspi.com>
In-Reply-To: <85256AE1.006F4CE8.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I would also vote for just an address to the initrd. We have the ability to
load different initrds depending on switches with our firmware now and I
would hate to see that go.



On Wednesday 10 October 2001 04:15 pm, you wrote:
> Val Henson <val@nmt.edu> wrote:
> > Indeed!  This is on my list of stuff to do - straighten out once and
> > for all how BI_INITRD works and then rewrite the Gemini boot process
> > to use it.  It seemed like we had two interpretations:
> >
> > 1. The BI_INITRD boot record contains the start address and the size
> >    of the initrd.
> >
> > 2. The BI_INITRD boot record contains the entire initrd itself (as a
> >    really large boot record).
> >
> > I have no preference either way, I just want someone to tell me which
> > way we're going to do it. :)
>
> I really need to be able to have the initrd image located anywhere, forcing
> it
> to be part of the bi_recs list is unacceptable. But if someone really wants
> option 2, maybe we can have two different bi_recs to suit everyone?

--
Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
