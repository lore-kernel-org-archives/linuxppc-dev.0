Mime-Version: 1.0
Message-Id: <v04220801b6d361120d09@[10.0.0.42]>
In-Reply-To: <XFMail.010312125719.pochini@shiny.it>
References: <XFMail.010312125719.pochini@shiny.it>
Date: Mon, 12 Mar 2001 21:56:46 -0800
To: Giuliano Pochini <pochini@shiny.it>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: [OT] 7450
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:57 PM +0100 3/12/01, Giuliano Pochini wrote:

>>But with five cycles of FP latency, scheduling becomes really important.
>
>Hmm, probably soft compiled for 604 runs fine on 7450 because it had
>similar latencies and a 6-stage pipeline.

The 604 has a 3-stage FPU, same as just about every other PPC Apple
has used.  The 7450 has a 5-stage FPU.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
