Date: Wed, 5 Dec 2001 19:41:13 -0300
From: Ricardo Scop <scop@digitel.com.br>
Reply-To: scop@digitel.com.br
Message-ID: <12820.011205@digitel.com.br>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, andy_lowe@mvista.com
Subject: Re[2]: Kernel oops while routing
In-reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E7F@mail.mediatrix.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E7F@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis,


Wednesday, December 05, 2001, 3:01:28 PM, you wrote:


JDB> IMHO, I could suggest an easier patch, that would result in modifying only
JDB> one line of code, without changing the 'tx_full' logic. In function
JDB> fcc_enet_start_xmit, instead of checking the ready bit (which is bad), we
JDB> could only check if cur_tx has reached dirty_tx, and then call
JDB> netif_stop_queue. Does it make sense?

Make sense to me. I'll try it out.

JDB> BTW, I worked hard last week in debugging the fcc_enet driver. It was not
JDB> handling correctly some transmission errors, resulting in the transmitter
JDB> completely stopping, without restarting. This is related to an errata
JDB> (CPM37) from Motorola about the 8260, concerning the way of restarting the
JDB> transmitter. If someone is interested, I can release a patch for that.

I'm interested!

Ricardo Scop                            mailto:scop@vanet.com.br
R SCOP Consulting

------------------------------------------------------------------
"What's money? A man is a success if he gets up in the morning and
goes to bed at night and in between does what he wants to do."
~Bob Dylan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
