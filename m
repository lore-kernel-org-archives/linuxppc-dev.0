Date: Fri, 16 Jan 2004 08:02:49 +0100
From: valvoline <valvoline@vrlteam.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: temp.c and cputable.c issues
Message-ID: <20040116070249.GT2658@adapter.n0skillz.org>
Reply-To: valvoline@vrlteam.org
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org> <125601c3db40$50b11bc0$3cc8a8c0@ANOSP> <20040115071604.GR2658@adapter.n0skillz.org> <12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 10:32:20AM +0100, Colin Leroy wrote:

> They're loaded in this order:
> snd-powermac
> snd-pcm-oss
> therm_adt7467

i gotta it! :)
for some strange reason i need to modprobe manually the i2c_west,
first of all...next if i modprobe:

snd-powermac
snd-pcm-oss
therm_adt7467

all works fine!. again, if therm_adt7467 is loaded first all the
system hangs with no further response if i try to modprobe something
related to i2c_west...maybe some kind of lock ?

under /var/log/everything.log, now, i can read the reports about
temperatures but no /dev/ devices is created; of course, i've modprobed
i2c_dev, but without any success...

regards.
--
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
