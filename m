Message-ID: <3AF72CA8.52163E55@mvista.com>
Date: Mon, 07 May 2001 19:15:52 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Eli Chen <eli@routefree.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel Paubert wrote:

> 10) swtcx. atomic_var, succeeds, but the variable has been modified in the
>    meantime, chaos ensues

How can this happen?  The reservation for the lwarx in 1) has
long been broken, so this swtcx. will fail.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
