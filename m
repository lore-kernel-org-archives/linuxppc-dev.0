Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<yellowdog-devel@lists.terrasoftsolutions.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: funny kernel death with ksoftirqd_CPUX taking up almost 100% of cpu?
Date: Wed, 10 Jul 2002 13:18:33 -0400
References: <200207101236.43005.kevin.hendricks@sympatico.ca> <20020710162403.16035@192.168.4.1>
In-Reply-To: <20020710162403.16035@192.168.4.1>
MIME-Version: 1.0
Message-Id: <200207101318.33120.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well,

I still have to debug that damn OOo 1.0.1 bridge problem so I have to go
back into OOo and gdb (which uses alot of memory) and try again.

If I run into it again, I will let you know.

If so, is there anything debug wise I can do that would help pinpoint the
problem.

Thanks,

Kevin

On July 10, 2002 12:24, Benjamin Herrenschmidt wrote:
> >I just experienced an alarming form of kernel death running a self
> > compiled SMP kernel with HIGHMEM enabled on my dual G4 -1gig machine.
> >
> >The kernel tree used is Ben's 2.4.19-pre10 one rebuilt for SMP support,
> > aec IDE driver and otherwise basically stock.
> >
> >I was debugging in gdb a large program and noticed typing got slower
> > and slower.  I quick check of top showed that ksoftirqd_CPU was taking
> > up almost 100% of the cpu.  I exited out of gdb and killed every
> > process I could think of but the usage of that kernel demaon stayed at
> > near 100%.
>
> BTW. It would be interesting to know if you can ever reproduce it...
>
> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
