Message-ID: <12b901c3db4a$81d1f7b0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <valvoline@vrlteam.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <20040114193910.GN2658@adapter.n0skillz.org> <20040114221018.GB983@stop.crashing.org> <20040114201153.GO2658@adapter.n0skillz.org> <125601c3db40$50b11bc0$3cc8a8c0@ANOSP> <20040115071604.GR2658@adapter.n0skillz.org>
Subject: Re: temp.c and cputable.c issues
Date: Thu, 15 Jan 2004 10:32:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi again,

> i've tried to use it, but the module is not compatible with i2c_west and
> soundcard, so the system hangs with no further response! (=

It works fine for me. What modules do you have ?

For me it is
therm_adt7467           9924  0
snd_pcm_oss            69188  0
snd_mixer_oss          22464  2 snd_pcm_oss
i2c_keywest            13320  0
snd_powermac           46020  1
snd_pcm               122708  2 snd_pcm_oss,snd_powermac
snd_page_alloc         13956  1 snd_pcm
snd_timer              28608  1 snd_pcm
snd                    61476  5
snd_pcm_oss,snd_mixer_oss,snd_powermac,snd_pcm,snd_timer
soundcore              11232  2 snd
i2c_core               29540  3 therm_adt7467,i2c_keywest,snd_powermac

They're loaded in this order:
snd-powermac
snd-pcm-oss
therm_adt7467

But the other way works too.

--
Colin
Ne disez pas disez, mais disez dites


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
