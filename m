From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: Symbol versioning problem
Date: Tue, 16 Jul 2002 16:21:37 -0700
Cc: stefan.eletzhofer@eletztrick.de, linuxppc-dev@lists.linuxppc.org
References: <200207101429.39539.remco@rvt.com> <200207161121.50509.remco@rvt.com> <20020716191248.GI20027@opus.bloom.county>
In-Reply-To: <20020716191248.GI20027@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200207161621.38242.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 16 July 2002 12:12, Tom Rini wrote:
...
> Well, have you tried backing up your .config, running 'make distclean',
> moving your config back (and re running your favorite config program)
> and trying again?

I did 'clean', not 'distclean', but your suggestion just sounded right.
The re-build after the distclean did not have the problem. Apparently some
crud stays around through 'make clean'. Maybe a corrupt .ver file...

Good catch, Tom.

Cheers,
Remco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
