Date: Thu, 15 Jan 2004 08:03:19 +0100
From: valvoline <valvoline@vrlteam.org>
To: Colin Leroy <colin@colino.net>
Subject: Re: temp.c and cputable.c issues
Message-ID: <20040115070319.GP2658@adapter.n0skillz.org>
Reply-To: valvoline@vrlteam.org
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org> <125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 09:19:37AM +0100, Colin Leroy wrote:

> What's your computer model ?
> You can try to do a
> `find /proc/device-tree -name fan|grep -v aliases`

i've an ibook G4/12". it's branded as PowerMac6,3. It should be
the lastest model available from apple.

> You may have an external chipset used to check temperatures and control
> the fan.

sure. there's an external chipset for temperature and fan control.
Under Macos X, i've set and get values from it several times...but
what about linux ?

--
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
