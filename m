Message-ID: <38877FD8.F4B3DD6B@netx4.com>
Date: Thu, 20 Jan 2000 16:36:24 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Ralf HECKHAUSEN <RHeckhau@frequentis.com>
CC: "<" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Embedded planet 860T CLLF HELP!
References: <s8877a79.049@mail.frequentis.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralf HECKHAUSEN wrote:


> Try to initialize PDDIR with 0x1fff instead of 0x1c58.

Right, now I remember....that doesn't work on pre Rev-D 860T parts.
Guess I need to add some silicon revision detection and set
accordingly.  Next version.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
