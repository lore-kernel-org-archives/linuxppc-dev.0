Message-ID: <3D526BCF.5090809@elsoft.ch>
Date: Thu, 08 Aug 2002 15:02:07 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Two little fixes for linuxppc_devel-2.4.19
Content-Type: multipart/mixed;
 boundary="------------040002010705090902040108"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040002010705090902040108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

The attached patch fixes the following issues:

     - arch/ppc/kernel/ocp.c
        missing export of "ocp_get_pm"


     - drivers/net/ibm_ocp/ibm_ocp_enet.h
        shifting of PM bits is done in wrong direction


Dave


--------------040002010705090902040108
Content-Type: application/octet-stream;
 name="linux-2.4.19-ppc.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-2.4.19-ppc.patch.bz2"

QlpoOTFBWSZTWVM2HaMAALHfgCAwSH///3u33OC/7/9EQAH9O4m7OCSUajIRgTCPUwnqbUxG
RjUDBGR6m1BJTRJhpMKZNDRoAANPKAGgAAilATRPRDRtIaABoA0AMg0AEpKMmg09EAAAAAAP
UAAaUwcH3n7mc2MFOWScLrilF9t0htrIRDHxiKCAF/smzF3VyxftNGXRo4YeF1bR8bmb7SKw
piNdZ/GMoLnTgeUMVnAHVSrh3kjwzEooIhwpykYMbMsLv2ey4cKRrC8acEEhHPiiL5LBBMYw
/mxxNjra0YZ2h4HE7a31PZnd8OpCIXyYLBPHSPkBh6LiQfxkIGPJOTTVuMafczp3F4xTURjL
ggM6SJuCOpXgqDKQXWs4QIHimXCCYXan6qRochaHo0m9ZkQVVLMzOaXLcCe2MZTOM0sEo0Q5
lPZSJKZpRyTj7yKZBiSmkbTEWhqZGacd8I+IIJR0hx0CmhP7UzSioeMjanwHiUTG5+tKtZYg
mFnUATv1E8kt+0HMTdfSC2KGwY8PNTIEHQXNPqhwIwkRIqQJzno0J8UoKAu34Spka22mBvO0
65pjXZq5WxLd4MDaa9Fw5odf+Gqi+lTaanUtyNLnhhNK66g7MIT3QilquYla1qg9VKtwa9RK
qK8NalBTBlxk2TErl/VxoViimZYS1wmD/F3JFOFCQUzYdow=
--------------040002010705090902040108--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
