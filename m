Message-ID: <3BE9D4B8.6A2E8603@mvista.com>
Date: Wed, 07 Nov 2001 17:41:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

I would move harrier.c and pplus_common.c to the "kernel" dir since they
are both bridge related files (kinda like the mpc10x_common.c file).

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
