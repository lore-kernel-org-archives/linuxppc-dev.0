Date: Fri, 16 Jan 2004 12:26:17 +0100
From: Colin Leroy <colin@colino.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: valvoline@vrlteam.org,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: temp.c and cputable.c issues
Message-Id: <20040116122617.1012d76c.colin@colino.net>
In-Reply-To: <Pine.GSO.4.58.0401161210280.14892@waterleaf.sonytel.be>
References: <20040114193910.GN2658@adapter.n0skillz.org>
	<20040114221018.GB983@stop.crashing.org>
	<20040114201153.GO2658@adapter.n0skillz.org>
	<125601c3db40$50b11bc0$3cc8a8c0@ANOSP>
	<20040115071604.GR2658@adapter.n0skillz.org>
	<12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP>
	<20040116070249.GT2658@adapter.n0skillz.org>
	<14de01c3dc1a$70830140$3cc8a8c0@ANOSP>
	<Pine.GSO.4.58.0401161210280.14892@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16 Jan 2004 at 12h01, Geert Uytterhoeven wrote:

Hi,

> If you look at <linux/kmod.h>, you'll notice your patch won't work, since
> request_module() is a dummy if CONFIG_KMOD is not set.

Well, it'll work for the majority and we can't do much if Kernel Module Loader isn't enabled...

--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
