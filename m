From: me@johngrimes.com
Date: Wed, 5 Jul 2000 09:47:13 -0500
Reply-To: me@johngrimes.com
To: Gwyn Judd <b.judd@xtra.co.nz>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
In-Reply-To: <20000706021718.A1398@thislove.dyndns.org>
Message-ID: <Pine.SGI.4.21.0007050940370.24528-100000@rainbow.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gwyn,
	It does look we might have the same bug.  I'm not using XFree86-4
either I'm also at XFree86-3.3.6-8a.  Did you say you had a rage128gl
card?  Although I do usually have xmms open when I crash I usually am not
playing sound so I don't think thats the problem.
	Where can I get the latest 2.2 series kernel and more importantly,
the latest rage128gl drivers (source off course is fine).  I use some hfs
so I don't really want to try 2.4pre series as yet.
	It also might be time to try Xfree86-4 (although I don't think
this would fix it).  I really want to get multihead to work but I didn't
have any luck with Xfree86-4 in the earlier incarnations to even get one
monitor working.
					John
PS I am using BootX but I don't think that is the problem.


On Thu, 6 Jul 2000, Gwyn Judd wrote:

>
> On Wed, Jul 05, 2000 at 04:10:22PM +0200, Michel Dänzer wrote:
>
> > What versions of X are you using? Someone reported lockups with the 4.0 r128
> > driver a long time ago and someone else suggested it might be bad interaction
> > between the graphics and sound devices.
>
> [gwyn@thislove:~]$ rpm -q XFree86
> XFree86-3.3.6-8a
>
> Looks like no dice there I'm afraid. I upgraded from 3.3.5-something a
> week or so ago to see if that would solve it but to no avail.
>
> --
> Gwyn Judd (b.judd@xtra.co.nz)
> But scientists, who ought to know
> Assure us that it must be so.
> Oh, let us never, never doubt
> What nobody is sure about.
> 		-- Hilaire Belloc
>
>

           John Grimes - Mission Planner for Chandra X-Ray Telescope
Phone 	(H) 617-591-1393	(W) 617-496-7663	(Fax) 617-495-7356
Email 	me@johngrimes.com	Web	http://www.johngrimes.com
Pager	1-800-473-6312 		Alphanumeric  4736312@mobilecomm.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
