Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: NAPI & 8xx/82xx enet.c driver?
Date: Mon, 1 Dec 2003 15:35:08 +0100
Message-ID: <002301c3b818$51c00350$0a01a8c0@LUMENTIS02>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I wounder if anyone has done some measurement on 8xx/82xx
current driver v.s a NAPI(New API) converted driver and willing
to share the resluts?

NAPI(see Documentation/networking/NAPI_HOWTO.txt) is supposed to reduce #irqs
under high load, which will increase small packet throughput. It got backported
to 2.4(around 2.4.20)

   Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
