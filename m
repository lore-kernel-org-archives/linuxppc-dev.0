Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Thu, 5 Aug 1999 13:56:11 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Some pmac patches
Message-Id: <19990805135611.009639@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed are a few patches I gathered from my dev. tree. (Available at
http://calvaweb.calvacom.fr/bh40/test.html too).

They include:

 - updated bootx.h and prom.c
 - a few fixes here or there (bootx l2cr stuff, adb sleep handler missing
break, features.c missing eieio, ...)
 - fix mouseman support and add slightly modified mousesystem A3 patch

Patches based on vger 2.2 branch (they should be 2.2-safe), they should
apply on 2.3 easily but if you need, I can make a specific patch.

Of course, if some people could give a try to the patches kernel to make
sure I didn't break anything before those are merged...
 

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





--==_Boundary-1_==
Content-Disposition: attachment; filename="ben_patches.tar.gz.sit"
Mime-Version: 1.0
Content-Type: multipart/appledouble; name="ben_patches.tar.gz.sit"; boundary="==_Boundary-2_=="
Message-Id: <19990805135638.005581>
Date: Thu, 5 Aug 1999 13:56:38 +0200

--==_Boundary-2_==
Mime-Version: 1.0
Content-Type: application/applefile; name="ben_patches.tar.gz.sit"
Message-Id: <19990805135639.023328>
Date: Thu, 5 Aug 1999 13:56:39 +0200
Content-Transfer-Encoding: base64

AAUWBwACAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAADAAAAVgAAABYAAAAJAAAAbAAA
ACAAAAAIAAAAjAAAABAAAAAEAAAAnAAAAAAAAAACAAAAnAAAAABiZW5fcGF0Y2hl
cy50YXIuZ3ouc2l0U0lURFNJVCEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/PFSW
/zxUlkttDAD/PFSW
--==_Boundary-2_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="ben_patches.tar.gz.sit"; x-mac-creator="03092e68"; x-mac-type="02e7edc0"
Message-Id: <19990805135639.024236>
Date: Thu, 5 Aug 1999 13:56:39 +0200
Content-Transfer-Encoding: base64

U0lUIQABAAAYB3JMYXUC/wAAABZ//wAAEmJlbl9wYXRjaGVzLnRhci5nevQK5AAA
AAEC+j2AAvoQygAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/////0d6aXBHemlw
AQCzz0fQs89H0AAAAAAAABeBAAAAAAAAF4EAACInAAAAAAAAuTUfiwgIbmypNwAD
YmVuX3BhdGNoLnRhcgDsO9ty28hy8tlNbajUSeUpeUmq+mhrvaR4EQASpETLjnWh
14olUSVStk+8LhREgiJKIIDgYkln16l9yV/kUqnKn+Q38pCHPOYheU+V0z0zAAES
vMjXU4lQlklipnt6unv6NjOuHvSGhr+x8gkfqEmNhgorAHJDlegT5FqNfYpHAqg3
VEWpqw1JwVapUZdXQP2UREVP6Ae6B7BybtjD+f0Mz/8cBH3exxXyr+y4rmXsO+G5
ZXxsZbi9/KtKtXon/8/xZMq/cqJ7hh18rDFkSarXazPlL8uyGsm/Likk/5qq1lZA
+lgEzHv+n8t/5Q/+9JuVe1nv8e9X+O9I/P4K/57j3zf49/XKyr0z8R5//+ov8PNP
8C+H38v4CUKrPjXtd8+nfd5tw7+8287v/hK92Fj59b0/uvfPX/37yj+t/Pevvnn3
P+/+418ffzn67p4PfjLtv+71hhXX7VVY6wePscj+16VGbP/laoO9Uet39v+zPEvY
/3vNlbH9/+OVJez/R1agu+fLPO+2v//7d9uFjV/E727rZXfvxUGL6UuW0rCX9/4Q
/6M/5bMQ+fv1fI0suDfJh68fPf3Pcgm//Tnx5OjF7i5+X/3qv969+6K00pNt//1R
+SOu3tvYf6mBuaCsNuS7+P/zPLe1/79eWcb+f1wFunu+zIP2/x/o7xfxO2X/X2VB
3Nn//wv2v++Zb9DaVUZ6z7QDxx9+2EK+hf1X6/U6gCJJVenO/n+W57b2/89WlrD/
H1mB7p4v86Dt/8d32/m/+0X8Tth/deUmC+LO/mfb/4N/k3638vts/z9lxj7f/suy
mqj/KyrVf6p15a7+81mevjkYQDk89qD8EjZC39vwvd6Gcd2zwr4BlmmH1xXHMy+Y
gmyggmxcGp5tWBsDQw9Cz6j0eKfZ7avlcnkpRLlOaMMT4xyUTVCqzZrUrEogb21t
rRaLxUWj5J54JvxVaCEkyEpTUpq1LQ78+DGUt5SSXIcifVTh8eNVyPmBF/YC6Btv
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
1weTAHgAAA==

--==_Boundary-2_==--

--==_Boundary-1_==--



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
