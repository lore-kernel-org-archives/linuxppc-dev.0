Date: Sat, 15 Jan 2000 10:05:26 +0100
From: Olaf Hering <olh@suse.de>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sysrq support
Message-ID: <20000115100525.J25867@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <387F5993.D88AF466@denise.shiny.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <387F5993.D88AF466@denise.shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii

On Fri, Jan 14, Giuliano Pochini wrote:

> 
> 
> Is sysrq supported ?  On my Pmac7300 2.2.14 compile dies with:
> 
> keyboard.c: In function `handle_scancode':
> keyboard.c:252: structure has no member named `ppc_kbd_sysrq_xlate'

SysRq is broken since 2.2.14pre5.

The attached patch should fix it. I guess the patch can go into the main
kernel...

It is only tested on a PowerMac, the mbx_setup.c maybe need some changes
(definition of SYSRQ_KEY). 

Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

--zYM0uCDKw75PZbzx
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="zzz_ppc_sysrq.dif.gz"
Content-Transfer-Encoding: base64

H4sICISAdjgCA3p6el9wcGNfc3lzcnEuZGlmAOWYX2+bMBDAn+FTWOtLUkoChEAg29StTadu
Xfcn2qQ9IQecxioh1ECXSu13nw0JcyhQ6KI9bJUK7XF3xne/u3Pi4fkcyAm5BD4OkrWs9bSe
qvemyXTSh8Rd9MPQ7V8jEiC/D8MkciIUJ2HPfazei+4iclNrJMqy3HIdYQpj8B4GAIyAoti6
ag8MoCmKIkqS9KyXEM4IzjyaQNNszbKVQebx+BjIhqYfmUDKbsfHIhCoG2fp9a5nnpMEaB0i
N0b0zxC8ApffLi7Guyo+8iKQ/5Sq4ADHzuJnQUXmVdJdOGsfxkjINaStBrtVagERHOA58NAc
B8jrnHy6PDt/57y9+OCcTr4756eTLri/r3nsfPx0+u1i0hXzTbDlsIfYyjiIftKV0nAyEft/
LHotGHIXJGzNEG/UkCHeZD8M1XnUbZVjSB8dGUCiV1VJETrAgesnHgIvYbTsQ2/WW7wuShd3
HoGpXJRo/mh+wCY3H9+8Oz9xpj+mX7+wR7zRNbqbrSDxmJ10gAKaCFHiPL+I8RL1Fi94kb9y
oe9gclOQ45E2tJgs24HJqkC31KNRVgV1jIfuVjouaBZRzzQ30nFKasVOZaGmHjI3nJAVxxPV
UW6TLuZ8mPygGsp6qLN3SuMoCHQrD/QX+RHKYmJZLCZDRW8SkyVsHJSN6h9HZeOnXVgqjHbj
YliP4nKQx2WoKmlcVGMbl8ao7ImUlqA8g5NKTB7d2/TC5WzduhVyNg07IWexn0ZY43BoKwbX
B9W0D6rlfZC6KemDlMeFh8K/3wmzNzaGad8zrJLp/0+wnPO6r2NCG+BDmt3WxPNGDZHnTfbD
/I5H/gA5oJPf1szf0A8NBj29mmXMIw/DGbwrAX+OYJwQVF8SNdSDNrSnJ101nfGGOmrQtwvj
bF/TrO0we84sqxxlXC20gpig9idY3qgpxJzJniCu8TigzZvr3Gbauc0jqwTi1E1wS+CyBFYC
b1Gwj+7dmueRoTGeR7SF/8/nkIdamDfh69OoyxkZ28hXUlRtUgFytUEBOnVkD9WnMW7sT7Hs
gfobYnPAeKDXDGIaomycgWK0O9WZoB+DRRmtY1pAIAkifEWnIfBXwRXIUzGuBb3GKOe8fwgI
ilYJcRGAPgM7xqsAHPZ3X5mgmwRFMb1f0cedbqtE50OkcZhzi4ZpzvWf16yq3e1+X6Obtsqf
Ma3sg+r2vHa7wp4gdA635d3t5BlwF5CAVDYuKG7Ku9thwu4TVb7rTzgsKdOiSglYOycxgRLw
+eQc4ICCNocuiljyfwFl6lNYmxMAAA==

--zYM0uCDKw75PZbzx--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
