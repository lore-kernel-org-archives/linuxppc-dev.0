From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12
Date: Sun, 14 Oct 2001 09:17:11 -0400
References: <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there> <20011013195117.29022@smtp.wanadoo.fr>
In-Reply-To: <20011013195117.29022@smtp.wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_N867XSOT1FCJCVLIDFAF"
Message-Id: <20011014131455.VGFQ17332.tomts11-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_N867XSOT1FCJCVLIDFAF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Justin,

Well, the idea of passing tag_info to the aic7xxx did help me boot but now
I am getting random kernel panics.  So I upgraded to your latest 6.2.4
with Ben's 2.4.12 and overnight when no activity was present, I got a
panic.

I rebooted and tried again and got another panic.

I have attached the relevant information from  /var/log/messages.
It seems to involve a different drive now on that same card.

Would you please take a look at the log and let me know if there is
anything that jumps out at you?

If not, I will simply downgrade to the old driver since I really need a
stable system right now and then try your driver again later sometime in
the future.

Thanks.

Kevin





--------------Boundary-00=_N867XSOT1FCJCVLIDFAF
Content-Type: application/x-gzip;
  name="aic624.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="aic624.log.gz"

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
JZ398uHDvwHj4dUmaiEAAA==

--------------Boundary-00=_N867XSOT1FCJCVLIDFAF--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
