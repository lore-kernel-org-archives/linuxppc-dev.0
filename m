Date: Thu, 25 Oct 2001 10:09:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ed.Swarthout@Motorola.com
Cc: tkoba@ike-dyn.ritsumei.ac.jp, jeglin@4pi.com,
	linuxppc-dev@lists.linuxppc.org, David Edelsohn <dje@watson.ibm.com>
Subject: Re: 2.4.13-pre5 crash when mounting proc
Message-ID: <20011025100904.D29107@cpe-24-221-152-185.az.sprintbbd.net>
References: <p04330100b7f7f805ef9a@[24.163.33.28]> <20011025.233136.74750056.tkoba@ike-dyn.ritsumei.ac.jp> <20011025083032.A29107@cpe-24-221-152-185.az.sprintbbd.net> <200110251653.f9PGrRd19727@pacific.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200110251653.f9PGrRd19727@pacific.somerset.sps.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 25, 2001 at 11:53:27AM -0500, Edward Swarthout wrote:
> Tom wrote:
> >
> > Um.  Is that _all_ that changed?  That really shouldn't have any effect
> > at all...  What compiler/binutils combo is this?
>
> Well it's important for the COPY_16_BYTES_EXCODE macro to switch back to
> the .text section or any following code will go in the __ex_table section!

Well now I feel stupid...  This should be fixed now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
