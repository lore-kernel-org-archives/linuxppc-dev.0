Date: Fri, 7 Jun 2002 16:59:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: can/should we use gcc 3.1 to compile kernels
Message-ID: <20020607235953.GR14252@opus.bloom.county>
References: <5.1.1.2.2.20020607222718.04331998@mail.lauterbach.com> <5.1.1.2.2.20020607225633.04090ea8@mail.lauterbach.com> <200206071939.44925.kevin.hendricks@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200206071939.44925.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jun 07, 2002 at 07:39:44PM -0400, Kevin B. Hendricks wrote:
> Hi,
>
> FYI: I counted 1175 occurences of warnings like the following:
>
> inode.c:2462: warning: concatenation of string literals with __FUNCTION__
> is deprecated
>
> So I hope someone has a nice sed or awk script to fix all of these in some
> automatic way.

There are/were rumblings of doing some standard debug macros for 2.5,
so...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
