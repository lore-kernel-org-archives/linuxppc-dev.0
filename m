Date: Thu, 18 May 2000 18:09:37 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Mike Hudson <Exoray@isys.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC+ & Full Duplex
In-Reply-To: <006601bfc119$0f4e5c00$d2d3470a@mike>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000518175956.15274G-101000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2124611198-570112040-958691377=:15274"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---2124611198-570112040-958691377=:15274
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 18 May 2000, Mike Hudson wrote:

> Takashi,
>
> I think we're talking about the same thing.
> "Server mode" is like a modified auto-power on that will
> ALWAYS boot the computer. i.e. it will boot whenever AC power is present.
>
> I'm going off the technote at the apple website
> (http://developer.apple.com/technotes/tn/tn1079.html) which specified
> direct hardware access to the CUDA, can we do this from user-space using
> ADB commands?

Surely.  There are a handful of pmac apps which excutes direct ADB/CUDA
commands.

>
> Here's what I was originally thinking about:
>
> cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_SVR_MODE,
>     CUDA_SVR_MODE_ENA)
> called somewhere in the kernel
> after
> #define CUDA_SVR_MODE 0x13 (from apple technote)
> #define CUDA_SVR_MODE_ENA 1
> etc..
> This could be called numerous ways.
>
> Either way, send over the source code to your little app, Takashi. It would
> be
> exponentially more elegant than a kernel patch.

I've modified what I had so that it will enable/disable the server mode.
See attached or other sources like /sbin/clock.  The little app I
mentioned is using 0xb cuda command for specifying some fixed time to
power up, and it's been available somewhere at
http://ppc.linux.or.jp/~toe/


Takashi Oe

---2124611198-570112040-958691377=:15274
Content-Type: APPLICATION/octet-stream; name="pmac_servermode.c.gz"
Content-ID: <Pine.A41.3.96LJ1.1b7.1000518180937.15274H@unlserve.unl.edu>
Content-Description: 
Content-Transfer-Encoding: BASE64

H4sICCh3JDkAA3BtYWNfc2VydmVybW9kZS5jAHVVbU/jOBD+3P6K2SC0aSlt
yp32dC3cCfGyWt2xIGD3PnRR5cZOY5HYqe1Qehz//WbitNvSIgVqj2eeeebF
4167CW0ochaPrTBPwuSai24MhyAUm2Six6WlXwguJf6/q3TgCpUC0Aq+fzk9
PPt2fkogXMdlLpQTnE5S54pBr8fFk8h0IUyXFUWGyDrvORGnSjthe07h149+
+72bujxDEP/BmS4WRk5TB+FZC46iKIJ79shsKuFadAFOswyqcwtGVLx5l+xu
mEGRTsClAmIkCcwISIzOIc50/IiBMcVhwlw3Jv3JAk3KDK5Y/CiMYbZbE7hP
pYXC6KlhOeAyMUKA1YmbI+AQFrqEmCl0julxRk5KJ0A6Au9pQwCYRpksSFYq
jhkjQg6zu2L3+es3+CyUMCyDm3KSyRj+lrFQVpA5Q+8ktClmE1mSxSVxuKs5
wKVGYOakVkMQEs8NYGUs7sn+aOmmxuyANhAyR8wN6ILsWkh3ARlzP00p/F6z
uSdVnJWYvWPruNTd9I8NkZFquilLYuWyTdFUOHRDsjUhs3mP8cmmJgnjkrNa
N8F8JUBNNb77fju+uj6/aO6hSCqxKYXouf9Lc08ozPRuu/HF19PdtnQC/aVx
s1RWThWmOk6ZwarOitGnBzhpNl682c3p2V8X951NjA5Eq+91uA1SZItR/9MD
nliHhYpBKgezUgoHJxANl9JNM7p+eLxFdqVeabXr1hwrlgt08KQlB17mRbiJ
1p6USafyq1rNl2aDVhL1Gwm1g6x4gIRjwCY6OJCtZqORFFhel4RYebwRHQhg
v3v0HHQAoUbyoTVsbqv8UAHKX2sepWVTEdKyBS9b2ugi2LcwOuT/zR7QkPY/
HAzqeQM3ei4M3kd4O29ghIXEy+p+WvEBLMfTu2Yr5dmgTn7upcRkPY0UmXiW
Luz7WChXVrh6LI7JKiRZwjtvakaVEav8KspvO6QmOjhqYYqrYwRXuJ4b6URI
EHTeASv/FTqplFtEQCYQKvhwsnlAadzO+r4deDzEcqUhOvucAoP1sDpYegRu
eB047OPm1TsKiZERjNeEsGHXGOGuha6PIfL+cYYbbcKADIL3ICvuv3qDqh9r
VM9hZwj4IuQ0lBOGldvmv8tTvY1WdcqZVFVxmJnGnbr327h5WpWFQkRBVWSc
eKq6FTQIFaeCrbvErIQeojVhVpAoJKxR9LCsEU63UvLwvdLcaWMw6ry0DiZY
H60dOE3thH/UmXUPrgdXxzZPqYFDcog8/BQNfVjEAcH5LEC/mOeL60vv386l
i1MgNS+IkTZEA1w1Jlivx+FS9pF/rKT1mImGO1RmXmU5qfqbOvUlrFT8Ta+C
eCXydVslHM3wzVdhQO8/TXws6vX49vyf210dRaq7UkFgb28glZEWHmbTBJ94
SxrLIn2oQninRKuBkVC+vQs/ffG537f1gKgS9ScEfjjxYIDp9xPH34E3zfg/
qDzMHk4JAAA=
---2124611198-570112040-958691377=:15274--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
