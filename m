Message-ID: <004f01c2d861$c6cdab30$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <D73A25AA6E54D511AD74009027B1110F3C066A@ORION>
Subject: lmw and stmw instructions not used copy functions 
Date: Wed, 19 Feb 2003 22:56:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I noticed that the lmw and stmw instructions are not used in copy_page(), clear_page() etc.
Aren't these instructions faster than a bunch of lwz/stw?
I assume they are inappropriate for some reason, but I would like to know why.
Would they work on 8xx?

    Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
