Message-ID: <00b101c3de3e$9c34f200$9104050a@JACKYLAM>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Small UDP packet performance
Date: Mon, 19 Jan 2004 11:44:55 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

    Currently, I find that my PPC 405EP board has some problem about the
throughput of small UDP packet (188 bytes). The throughput is just only
~0.01%. However, for large packet, say 1K, the throughput is very good. It
is more than 50%. Is it a problem of PPC Linux, ethernet driver or generic
Linux? Is there any way to tune it? Thanks.


Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
