Date: Thu, 15 Jan 2004 08:16:04 +0100
From: valvoline <valvoline@vrlteam.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: temp.c and cputable.c issues
Message-ID: <20040115071604.GR2658@adapter.n0skillz.org>
Reply-To: valvoline@vrlteam.org
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org> <125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 09:19:37AM +0100, Colin Leroy wrote:

> You may have an external chipset used to check temperatures and control
> the fan.

to be exact, there's an i2c thermostat named adt7467:

http://www.analog.com/UploadedFiles/Data_Sheets/115254175ADT7467_pra.pdf

i've tried to use it, but the module is not compatible with i2c_west and
soundcard, so the system hangs with no further response! (=

without the soundcards, the module load correctly, but i can't see
any new special device under /dev nor /proc...perhaps, the support is
stille experimental, or i've done some mistake in loading.

--
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
