Date: Sat, 6 Jan 2001 18:54:00 -0800
From: Keith Clayton <clay-ton@pacbell.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Endianness and comparing IP's
Message-ID: <20010106185400.A17606@yoda>
References: <20010106234445.44216E690@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010106234445.44216E690@apollo.valhalla.net>; from iain@sandoe.co.uk on Sat, Jan 06, 2001 at 11:37:24PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Good catch!


On Sat, Jan 06, 2001 at 11:37:24PM +0000, Iain Sandoe wrote:
>
>
> > /* convert the bytes of a 32-bit integer to little endian */
> > #define BSWAP32(c)
> > ((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24)
>
>  #define BSWAP32(c) \
> (((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24))
>
>
> will work as you expect it too... ;-)
>
> precedence is a funny thing...
>
> Iain.
>
>

--
<><><><><><><><><><><><>
Keith Clayton
clay-ton@pacbell.net

"If you don't trust me with your source code,
            why should I trust you with my computer?"

GPG key: http://www.jps.net/kclayton/keith_public_key.html
         http://www.keyserver.net

GPG fingerprint: 0C47 F1A1 0434 588C 9457  D53F D86A 5449 43F6 09A0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
