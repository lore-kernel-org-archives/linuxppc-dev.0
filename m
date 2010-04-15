Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f172.google.com (mail-yx0-f172.google.com
	[209.85.210.172]) by ozlabs.org (Postfix) with ESMTP id 48ED5B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 02:07:06 +1000 (EST)
Received: by yxe2 with SMTP id 2so1010453yxe.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Apr 2010 09:07:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <v2ma0706c7b1004150906p34b853a0r80e2bb751e034b97@mail.gmail.com>
References: <4BC682DC.1050200@billgatliff.com>
	<201004150921.47268.roman.fietze@telemotive.de>
	<4BC70E47.9010408@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
	<v2ma0706c7b1004150906p34b853a0r80e2bb751e034b97@mail.gmail.com>
Date: Thu, 15 Apr 2010 11:07:03 -0500
Message-ID: <v2pa0706c7b1004150907teae3383dwa4ee101d07daacfe@mail.gmail.com>
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
From: Bill Gatliff <bgat@billgatliff.com>
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: multipart/alternative; boundary=0016e6475b0282f3af048448aff0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6475b0282f3af048448aff0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I would love it if you posted your code! Thanks!!

b.g.

On Apr 15, 2010 8:53 AM, "Roman Fietze" <roman.fietze@telemotive.de> wrote:

Hello Bill,


On Thursday 15 April 2010 15:01:59 Bill Gatliff wrote:

> Are you talking about this code here?
>
...
Yes. I added a routine like

/* Swap frame buffer bytes in 32 bit value.  */
static __inline unsigned int
fbbits_swap32(unsigned int __bsx)
{
   return ((((__bsx) & 0xff000000) >> 8) | (((__bsx) & 0x00ff0000) << 8) |
           (((__bsx) & 0x0000ff00) >> 8) | (((__bsx) & 0x000000ff) << 8));
}


Then I added void shadowUpdatePackedSwapped16() and
shadowUpdatePackedSwapped32() which I was using instead of the
original *Weak functions, which in turn uses the above swap routine
when copying from shadow to the device.

If you want I can post (in the ML) or mail you the files that I
changed. A diff probably won't help a lot, because I think we changed
more than that, and we are using a pretty old XFree version.



Roman

--=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen
Breitwiesen ...

--0016e6475b0282f3af048448aff0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>I would love it if you posted your code! Thanks!!</p>
<p>b.g.<br>
</p>
<p><blockquote type=3D"cite">On Apr 15, 2010 8:53 AM, &quot;Roman Fietze&qu=
ot; &lt;<a href=3D"mailto:roman.fietze@telemotive.de">roman.fietze@telemoti=
ve.de</a>&gt; wrote:<br><br>Hello Bill,<br>
<p><font color=3D"#500050"><br>On Thursday 15 April 2010 15:01:59 Bill Gatl=
iff wrote:<br><br>&gt; Are you talking about this code here?<br>&gt; <br>..=
.</font></p>Yes. I added a routine like<br>
<br>
/* Swap frame buffer bytes in 32 bit value. =A0*/<br>
static __inline unsigned int<br>
fbbits_swap32(unsigned int __bsx)<br>
{<br>
 =A0 =A0return ((((__bsx) &amp; 0xff000000) &gt;&gt; 8) | (((__bsx) &amp; 0=
x00ff0000) &lt;&lt; 8) |<br>
 =A0 =A0 =A0 =A0 =A0 =A0(((__bsx) &amp; 0x0000ff00) &gt;&gt; 8) | (((__bsx)=
 &amp; 0x000000ff) &lt;&lt; 8));<br>
}<br>
<br>
<br>
Then I added void shadowUpdatePackedSwapped16() and<br>
shadowUpdatePackedSwapped32() which I was using instead of the<br>
original *Weak functions, which in turn uses the above swap routine<br>
when copying from shadow to the device.<br>
<br>
If you want I can post (in the ML) or mail you the files that I<br>
changed. A diff probably won&#39;t help a lot, because I think we changed<b=
r>
more than that, and we are using a pretty old XFree version.<br>
<p><font color=3D"#500050"><br><br>Roman<br><br>-- <br>Roman Fietze        =
        Telemotive AG B=FCro M=FChlhausen<br>Breitwiesen                  .=
..</font></p></blockquote></p>

--0016e6475b0282f3af048448aff0--
